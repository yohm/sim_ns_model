require 'chunky_png'
require 'json'

class NagelSchreckenberg

  def initialize(l, v, rho, p)
    @l = l
    @v = v
    @num_cars = (l*rho).to_i
    @p = p

    @state = Array.new(l) {|i| i < @num_cars ? 1 : 0 }
    @state.shuffle!
  end

  def update
  end

  def avg_v
    @state.inject(:+).to_f / @state.size
  end

  def flow
    avg_v * @num_cars / @l
  end

  def snapshot
    @state.dup
  end
end

unless ARGV.size == 7
  $stderr.puts "usage: ruby #{__FILE__} <lane length> <max v> <car density> <deceleration probability> <thermalization step> <measurement step> <seed>"
  raise "invalid argument"
end

l = ARGV[0].to_i
v = ARGV[1].to_i
rho = ARGV[2].to_f
p = ARGV[3].to_f
t_init = ARGV[4].to_i
t_measure = ARGV[5].to_i
seed = ARGV[6].to_i

srand(seed)

ns = NagelSchreckenberg.new(l, v, rho, p)
dt = t_init / 100
io = File.open("initial_time_series.dat", 'w')
t_init.times do |t|
  $stderr.puts "#{t} / #{t_init}" if t % dt == 0
  ns.update
  io.puts "#{t} #{ns.avg_v} #{ns.flow}"
end
io.close

dt = t_init / 100
v_sum = 0.0
flow_sum = 0.0
snapshots = []
t_measure.times do |t|
  $stderr.puts "#{t} / #{t_init}" if t % dt == 0
  ns.update
  v_sum += ns.avg_v
  flow_sum += ns.flow
  snapshots << ns.snapshot if t_measure - t <= 100 # save last 100 snapshots
end

# dump_snapshots_to_png(snapshots, 'traffic.png')

File.open('_output.json', 'w') do |io|
  v_avg = v_sum / t_measure
  flow_avg = flow_sum / t_measure
  io.puts( {velocity: v_avg, flow: flow_avg}.to_json )
end

