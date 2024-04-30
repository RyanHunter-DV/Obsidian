"""
# Object description:
Core, the kernal class of rhshell tool. includes all other objects, and will start the main
loop to call different apis to execute different actions
"""
class Core ##{{{
	## init(), 
	# initialize other objects as class fields
	def init(); ##{{{
		# puts "#{__FILE__}:(init()) is not ready yet."
		prompt = PromptPanel.new();
		ui     = UserPanel.new();
		exe    = ExecutePanel.new();
		@uiThread = Thread.new{ui.start(self)};
		#TODO
	end ##}}}

	## run(), start main loop to run this tool
	def run(); ##{{{
		@uiThread.join;
		@exeThread.join;
	end ##}}}
end ##}}}