require 'chunky_png'
require 'json'

class NagelSchreckenberg

  def initialize(l, v, rho, p)
    @l = l
    @v = v
    @num_cars = (l*rho).to_i
    @p = p

    @state = Array.new(@l) {|i| i < @num_cars ? 0 : nil }
    @state.shuffle!
  end

  def update
    updated_v = @state.map {|v| v ? v+1 : nil }
    current = @state + @state # to handle PBC
    updated_v = updated_v.each_with_index.map do |v,idx|
      if v
        forward = current[idx+1..idx+v].index {|x| x}
        forward || v
      end
    end
    updated_v = updated_v.map do |v|
      if v
        (v > 0 and rand < @p) ? v-1 : v
      end
    end

    # move
    @state = Array.new(@l,nil)
    updated_v.each_with_index do |v,idx|
      if v
        @state[(idx+v) % @l] = v
      end
    end
  end

  def avg_v
    @state.compact.inject(:+).to_f / @state.size
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
dt = t_init / 100 + 1
io = File.open("initial_time_series.dat", 'w')
t_init.times do |t|
  $stderr.puts "#{t} / #{t_init}" if t % dt == 0
  ns.update
  io.puts "#{t} #{ns.avg_v} #{ns.flow}"
end
io.close

dt = t_measure / 100 + 1
v_sum = 0.0
flow_sum = 0.0
snapshots = []
t_measure.times do |t|
  $stderr.puts "#{t} / #{t_measure}" if t % dt == 0
  p ns.snapshot
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

