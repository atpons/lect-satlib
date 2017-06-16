require "../satrb.rb"
require "logger"
require "socket"

@ip = "localhost"
@port = 20000

@log = Logger.new(STDOUT)

@c = 0

v_num = 20

torf = [true,false]
@var = Array.new

torf.repeated_permutation(v_num){|l| @var.push(l)}

s_begin = 1
s_end = @var.count / 2

c_begin = @var.count / 2 + 1
c_end = @var.count

@log.info("[*] Connecting server to #{@ip}:#{@port} for initialize information")
sock = TCPSocket.open(@ip, @port)
sock.write([c_begin,c_end])
sock.close


@log.info("[*] Connecting server to #{@ip}:#{@port} for booleans")
sock = TCPSocket.open(@ip, @port)
sock.write (@var[c_begin-1..c_end-1])
sock.close

@log.info("[*] Calculation on 01 (#{s_begin} to #{s_end})")
@var[s_begin-1..s_end-1].each do |bool|
  a = Passat::Boolean.new
  a.input(bool)
  a.file_load("20.cnf")
  @c += 1
#  @log.debug("[-] Solving SAT on 01 (times: #{@c})")
  if a.check
    @log.info("[*] Solved and SAT on 01 (times: #{@c})")
    break
  end
end

