# aop
### execution
- execution(modifiers-pattern? ret-type-pattern declaring-type-pattern? name-pattern(param-pattern)throws-pattern?)
  - returning type pattern,name pattern, and parameters pattern是必须的.
  - ret-type-pattern:可以为*表示任何返回值,全路径的类名等.
  - name-pattern:指定方法名,*代表所以,set*,代表以set开头的所有方法.
  - parameters pattern:指定方法参数(声明的类型),(..)代表所有参数,(*)代表一个参数,(*,String)代表第一个参数为任何值,第二个为String类型.
- 举例说明:
  - 任意公共方法的执行：execution(public * *(..))
  - 任何一个以“set”开始的方法的执行：execution(* set*(..))
  - AccountService 接口的任意方法的执行：execution(* com.xyz.service.AccountService.*(..))
  - 定义在service包里的任意方法的执行：execution(* com.xyz.service.*.*(..))
  - 定义在service包和所有子包里的任意类的任意方法的执行：execution(* com.xyz.service..*.*(..))
  - 定义在pointcutexp包和所有子包里的JoinPointObjP2类的任意方法的执行：execution(* com.test.spring.aop.pointcutexp..JoinPointObjP2.*(..))")
- ***> 最靠近(..)的为方法名,靠近.*(..))的为类名或者接口名,如上例的JoinPointObjP2.*(..))
  - pointcutexp包里的任意类.within(com.test.spring.aop.pointcutexp.*)
  - pointcutexp包和所有子包里的任意类.within(com.test.spring.aop.pointcutexp..*)