require "../satrb.rb"
require "socket"
require "logger"

@log = Logger.new(STDOUT)
@port = 20000

@log.info("[*] Listening on #{@port} for initialize information")
s0 = TCPServer.open(@port)
sock = s0.accept
while buf = sock.gets
  buf = eval(buf)
  @c_begin = buf[0]
  @c_end = buf[1]
end
sock.close
s0.close

@log.info("[*] Listening on #{@port} for booleans")
s0 = TCPServer.open(@port)
sock = s0.accept
while buf = sock.gets
  @var = eval(buf)
end
sock.close
s0.close

@c = 0
#c_begin = @var.count / 2 + 1
#c_end = @var.count

@log.info("[*] Calculation on 01 (#{@c_begin} to #{@c_end})")
@var.each do |bool|
  a = Passat::Boolean.new
  a.input(bool)
  a.file_load("20.cnf")
  @c += 1
#  @log.debug("[-] Solving SAT on 02 (times: #{@c})")
  if a.check
    @log.info("[*] Solved and SAT on 02 (times: #{@c})")
    break
  end
end
