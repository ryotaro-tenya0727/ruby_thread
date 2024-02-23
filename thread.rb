p Thread.main
p Thread.list
Thread.new { 'Hello World' } #別のスレッドの作成
Thread.fork { 'Good Morning World' } #別のスレッドの作成②

#メインスレッドに加えて上で作成した２つのスレッドが配列に格納されている。
p Thread.list
p Thread.list.size
