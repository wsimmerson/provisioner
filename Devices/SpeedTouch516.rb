require 'net/telnet'

module SpeedTouch516
  
  def self.run
    puts "\nSpeedTouch 516 Provisioner on the run...
    Configuring for IP Block"
    puts "\nEnter SpeedTouch IP (default: 192.168.1.254) :"
    device = gets.chomp
    if device == ''
      device = "192.168.1.254"
    end
    
    puts"Username: "
    username = gets.chomp
    puts "Password: "
    password = gets.chomp
    
    puts "\n
           Config Info
    **************************"
    puts "Enter first 'usable' IP in the block: "
    firstip = gets.chomp
    puts "Enter the subnet mask: "
    netmask = gets.chomp
    
    cmds = [
      username,
      password,
      ":ip ipadd intf=LocalNetwork addr=#{firstip} netmask=#{netmask} addroute=enabled",
      ":ip ipconfig addr=#{firstip} preferred=enabled primary=enabled",
      ":nat ifconfig intf=Internet translation=disabled",
      ":nat ifconfig intf=LocalNetwork translation=disabled",
      ":firewall config state=disabled",
      ":dsd config state=disabled",
      ":ids config state=disabled",
      ":mlp role addpriv name=Administrator access=anyaccess service=anyservice",
      ":service system ifadd name=TELNET group=wan",
      ":dhcp server config state=disabled",
      ":saveall",
      ":exit"]
    
      begin
        tn = Net::Telnet::new("Host" => device,
                              "Timeout" => 10,
                              "Prompt" => /[:$%#>]|}=> \z/)
          
        cmds.each { |cmd|
          tn.cmd(cmd) { |msg| print msg }
        }
      rescue
        puts "\nAn Error Occurred!"
      end
    
    puts "\nSpeedTouch 516 Provisioner run complete."
    
  end
  
end