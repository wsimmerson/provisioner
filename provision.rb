require_relative 'Devices/SpeedTouch516.rb'
require_relative 'Devices/MikroTik.rb'


puts "

#####################################################
               Welcome to Provisioner
                 By Wayne Simmerson
#####################################################

Choose a device to provision:

1. SpeedTouch 516
2. MikroTik Routerboard

Enter Number > "

device = gets.chomp().to_i

case device
  when 1
    SpeedTouch516.run()
  when 2
    Microtik.run()
  else
    puts "Invalid/No device selected"
end