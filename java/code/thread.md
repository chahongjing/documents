### 多线程刷数据
~~~ java
BlockingQueue<Runnable> queue = new ArrayBlockingQueue<>(4); //固定为4的线程队列
ThreadPoolExecutor executor = new ThreadPoolExecutor(2, 6, 1, TimeUnit.DAYS, queue);
executor.setRejectedExecutionHandler((Runnable r, ThreadPoolExecutor exe) -> {
    try {
        exe.getQueue().put(r);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
});
int i = 0;
while (i < 100) {
    final int m = i;
    executor.submit(new Thread(() -> {
        System.out.println(String.format("threadName=%s;i=%d, size=%d", Thread.currentThread().getName(), m, queue.size()));
        try {
            TimeUnit.MILLISECONDS.sleep(100L);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }),"thead" + i);
    i++;
}
~~~