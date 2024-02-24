
# p Thread.main
# p Thread.list
# Thread.new { 'Hello World' } #別のスレッドの作成
# Thread.fork { 'Good Morning World' } #別のスレッドの作成②

# #メインスレッドに加えて上で作成した２つのスレッドが配列に格納されている。
# p Thread.list
# p Thread.list.size

# def time1
#   sleep(2)
#   puts Time.now.strftime("%H時%M分%S秒")
# end

# def time2
#   sleep(2)
#   puts Time.now.strftime("%H時%M分%S秒")
# end

#スレッドを使用しない場合
# time1 #=> 13時23分30秒
# time2 #=> 13時23分32秒

## Threadを利用した例
# threads = []
# threads << Thread.new { time1() }
# threads << Thread.fork { time2() }
# threads.each { |thr| thr.join }

# thread = Thread.start {time1()}

require "gvl-tracing"

# def main
#   GC.disable
#   end_time = Time.now + 0.01

#   while Time.now < end_time do
#     1 + 1
#   end

#   puts "0.01秒間で1 + 1の計算が完了しました。"
#   GC.enable
# end

# GvlTracing.start("example1.json") do
#   GC.disable
#   thread = Thread.new do
#     sleep 0.001
#   end

#   two_threads = 5.times.map do |i|
#     Thread.new do
#       main
#     end
#   end

#   thread.join
#   two_threads.map(&:join)
#   GC.enable
# end

class A
  def initialize
  end

  def method(params)
    @result = params # 処理①：インスタンス変数の更新

    sleep 0.0001 # 処理②：長く時間のかかる処理

    @result # 処理③：インスタンス変数の参照
  end
end



a_instance = A.new

GvlTracing.start("example2.json") do
  GC.disable
  [1, 2].map do |i|
    Thread.new do
      puts a_instance.method(i)
    end
  end.map(&:join)
end
