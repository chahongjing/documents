### json
~~~ delphi
dataJson := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(jsonDataStr), 0) as TJSONObject;
dataJson.GetValue('shenheyijian').ToString;
for i := 0 to json.Size - 1 do
begin
  tempStr := StringReplace(TJSONPair(json.Get(i)).JsonString.ToString, '"', '', [rfReplaceAll]) ;
  jsonArr := TJSONArray(json.GetValue(tempStr)) as TJSONArray;
  if((jsonArr <> nil) and (jsonArr.Size > 0)) then begin
    wordOperate.debugLog(tempStr + '-------' + jsonArr.tostring());
    for j := 0 to jsonArr.size - 1 do
      begin
      jsonTemp := jsonArr.Get(j) as TJSONObject;
      // 文件路径
      if(jsonTemp.GetValue('shitiid') <> nil)then
      begin      
        shitiid := StringReplace(jsonTemp.GetValue('shitiid').ToString(), '"', '',[rfReplaceAll]);
      end;
    end;
  end;
end


jsonShenHe.AddPair('shenheyijianlist', jsonArr);



function TprocFrame.fnStr2Base64ForUtf8(theStr:string):string ;
var base64 : TIdEncoderMIME;
    tmpBytes : TBytes;
begin
  base64 := TIdEncoderMIME.Create(nil);
  try
    base64.FillChar := '=';
    tmpBytes := TEncoding.UTF8.GetBytes(theStr);
    Result := base64.EncodeBytes(TIdBytes(tmpBytes));
  finally
    base64.Free;
  end;
end;

function TprocFrame.fnBase642StrForUtf8(theStr : string) : string;  //base64 解码
var base64 : TIdDeCoderMIME;
    tmpBytes : TBytes;
begin
  base64 := TIdDecoderMIME.Create(nil);
  try
    base64.FillChar := '=';
    tmpBytes := TBytes(base64.DecodeBytes(theStr));
    Result := TEncoding.UTF8.GetString(tmpBytes);
  finally
    base64.Free;
  end;
end;
~~~
### file and memory
~~~ delphi
ms := TMemoryStream.Create();
ms.WriteBuffer((PChar('字符串'))^, Length(str));  
ms.SaveToFile('d:\2.txt');
ms.Free;

// 创建目录
if not DirectoryExists(ExtractFileDir(localFile)) then ForceDirectories(ExtractFileDir(localFile));

if FileExists(docPath) then
      DeleteFile(docPath);

procedure TwordOperateFrame.debugLog(log:string);
var
  F: TextFile;
  filePath:string;
begin
  filePath := ExtractFileDir(ParamStr(0)) + '\logs\debug' + FormatDateTime('yyyy-mm-dd',Now()) + '.log';
  if(not DirectoryExists(ExtractFilePath(filePath))) then
  begin
    ForceDirectories(ExtractFilePath(filePath));
  end;
  AssignFile(F, filePath);
  if(not FileExists(filePath)) then
  begin
    rewrite(F);
  end else begin
    Append(F);  //打开准备追加
  end;
  Writeln(F, FormatDateTime('yyyy-mm-dd hh:nn:ss',Now()));
  Writeln(F, log);
  CloseFile(F);
end;

查找文件
tempStr := filepath + 'ST_*';
    findCount := FindFirst(tempStr, faAnyFile, SearchRec);
    while findCount = 0 do
     begin
       if (SearchRec.Name<>'.')  and (SearchRec.Name<>'..') and (SearchRec.Attr<>faDirectory) then
       begin
         suffix := LowerCase(ExtractFileExt(SearchRec.Name));
         if((suffix ='.html')) then
         begin
           DeleteFile(filepath + '\' + SearchRec.Name);
         end;
       end;
       findCount := FindNext(SearchRec);
     end;
    FindClose(SearchRec);

删除匹配的文件
procedure TfrmTools.deleteFilePartern(dir, partten: String);
var
  findCount: Integer;
  SearchRec: TSearchRec;
begin
  findCount := FindFirst(dir + partten, faAnyFile, SearchRec);
  while findCount = 0 do
   begin
     if (SearchRec.Name<>'.')  and (SearchRec.Name<>'..') and (SearchRec.Attr<>faDirectory) then
     begin
       DeleteFile(dir + SearchRec.Name);
     end;
     findCount := FindNext(SearchRec);
   end;
  FindClose(SearchRec);
end;

文件处理
RenameFile('Oldname', 'Newname');
CopyFile(PChar('Oldname'), PChar('Newname'), False);
MoveFile(PChar('Oldname'), PChar('Newname'));
DeleteFile(文件名);
ExtractFileExt获取文件后缀
删除文件夹（非空）
RemoveDir(ExtractFileDir(tempPath));
~~~
### http
~~~ delphi
procedure TfrmTools.getRequest(Url : string);
  var
   IdHttp : TIdHTTP;
   ResponseStream : TStringStream; //返回信息
   ResponseStr : string;
  begin
   //创建IDHTTP控件
   IdHttp := TIdHTTP.Create(nil);
   //TStringStream对象用于保存响应信息
   ResponseStream := TStringStream.Create('');
   try
     try
       IdHttp.Get(Url,ResponseStream);
     except
       on e : Exception do
       begin
         ShowMessage(e.Message);
       end;
     end;
     //获取网页返回的信息
     ResponseStr := ResponseStream.DataString;
     //网页中的存在中文时，需要进行UTF8解码
     ResponseStr := UTF8Decode(ResponseStr);
   finally
     IdHttp.Free;
     ResponseStream.Free;
   end;
  end;

procedure TfrmTools.PostReqeust(Url : string; param: TJsonObject; ResponseStream : TMemoryStream);
var
  IdHttp : TIdHTTP;
  ResponseStr ,key,value: string;
  RequestList : TStringList;     //请求信息
  RequestStream : TStringStream;
  i: integer;
  rs : TStringStream; //返回信息
begin
  //创建IDHTTP控件
  IdHttp := TIdHTTP.Create(nil);
  //TStringStream对象用于保存响应信息
  rs := TStringStream.Create('');
  RequestStream := TStringStream.Create('');
  RequestList := TStringList.Create;
  try
    try
      //以列表的方式提交参数
      for i := 0 to param.Size - 1 do
      begin
        key := StringReplace(TJSONPair(param.Get(i)).JsonString.ToString, '"', '', [rfReplaceAll]);
        value := param.GetValue(key).ToString;
        Delete(value, 1, 1);
        Delete(value, value.length, 1);
        RequestList.Add(key + '=' + HttpEncode(value));
      end;
      IdHttp.Post(Url, RequestList, ResponseStream);
      // key := rs.DataString;

      //以流的方式提交参数
      //RequestStream.WriteString('text=love');
      //IdHttp.Post(Url,RequestStream,ResponseStream);
    except
      on e : Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
    //获取网页返回的信息
    //ResponseStr := ResponseStream.DataString;
    //网页中的存在中文时，需要进行UTF8解码
    //ResponseStr := UTF8Decode(ResponseStr);
  finally
    IdHttp.Free;
    RequestList.Free;
    RequestStream.Free;
  end;
end;
~~~