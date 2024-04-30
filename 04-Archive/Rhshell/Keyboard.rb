require 'KeyAction'

"""
# Object description:
Keyboard, object used to detect user input keys and return
internal recognizable key actions in hash type: keyAction{:char='',:action=:actionName}
"""
class Keyboard ##{{{

	TAB    = ;
	CTRL_C = 3;
	BACKSP = ;
	ENTER  = ;


	## init, description
	def init; ##{{{
		puts "#{__FILE__}:(init) is not ready yet."
	end ##}}}

	## detectKeyAction(key=''), return hash typed key actions based on input user
	# key ascii value.
	def detectKeyAction(key=''); ##{{{
		puts "#{__FILE__}:(detectKeyAction(key='')) is not ready yet."
	end ##}}}
end ##}}}