class DifferentNick < Citrus::Plugin
	def initialize(*args)
		super
		@prefix = @config['prefix'] || '!nc'
	end

	def on_privmsg(prefix, channel, message)
      case message
      when /^#{@prefix}$/i
        notice(channel, different_check(prefix))
      end
	end

	private
	def different_check(prefix)
      /^([^!]+)!~([^@]+)@.+$/ =~ prefix
      nick = $1
      user = $2
      
      if nick == user
        "NICKとUSERが一致しています"
      elsif /#{user}_+/ =~ nick
        "NICKが変更されています(現在のNICK: #{nick})"
      else
        "NICKとUSERが違うようです(NICK: #{nick}, USER: #{user})"
      end
	end
end

