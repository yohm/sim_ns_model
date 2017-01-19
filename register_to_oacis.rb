repo_dir = File.expand_path(File.dirname(__FILE__))

localhost = Host.find_by_name("localhost")

sim_name = "Nagel_Schreckenberg"
raise "simulator #{sim_name} already exists" if Simulator.where(name: sim_name).exists?

sim = Simulator.create!(
  name: sim_name,
  command: "#{repo_dir}/run.sh",
  support_input_json: false,
  print_version_command: "cd #{repo_dir} && git describe --always",
  parameter_definitions: [
    {key: "l", type: "Integer", default: 200, description: "road length"},
    {key: "v", type: "Integer", default: 5, description: "max velocity"},
    {key: "rho", type: "Float", default: 0.3, description: "density of cars"},
    {key: "p", type: "Float", default: 0.1, description: "deceleration probability"},
    {key: "t_init", type: "Integer", default: 100, description: "thermalization steps"},
    {key: "t_measure", type: "Integer", default: 300, description: "measurement steps"}
  ],
  description: <<EOS
### nagel\\_schreckenberg\\_model

- Simulation code of Nagel-Schreckenberg model written in Ruby.
    - [https://en.wikipedia.org/wiki/Nagel%E2%80%93Schreckenberg_model](https://en.wikipedia.org/wiki/Nagel%E2%80%93Schreckenberg_model)
- source code is available on [github](https://github.com/yohm/nagel_schreckenberg_model)
EOS
  )

sim.executable_on.push localhost

