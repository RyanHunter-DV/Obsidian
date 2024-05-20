`ifndef rhAhb5MstConfig__svh
`define rhAhb5MstConfig__svh
/************************************************************************************/
// Author: RyanHunter
// Created: 2022-12-22 06:29:20 -0800
// Description:
// This file is automatically generated by MDC-v2, any issues found
// here should be modified in its source markdown document the same
// dir structure in Git/Obsidian/...
/************************************************************************************/

class RhAhb5MstConfig extends RhAhb5ConfigBase;
	// RhAhb5IfControlBase ifCtrl;
	string interfacePath;
	`uvm_object_utils_begin(RhAhb5MstConfig)
	`uvm_object_utils_end
	extern task sendAddressPhase(RhAhb5TransBeat b,int outstanding);
	extern task sendDataPhase(RhAhb5TransBeat b,output isError);
	extern function uvm_bitstream_t getSignal(string signame);
	extern task waitCycle(int c=1);
	extern task driveIdleBeat(int cycle=1,int os);
	extern function  new(string name="RhAhb5MstConfig");
endclass
task RhAhb5MstConfig::sendAddressPhase(RhAhb5TransBeat b,int outstanding);
	bit busy = outstanding? 1'b1 : 1'b0;
	ifCtrl.driveAddressPhase(b,busy);
endtask
task RhAhb5MstConfig::sendDataPhase(RhAhb5TransBeat b,output isError);
	if (b.write)
		ifCtrl.driveDataPhase(b,isError);
	else ifCtrl.waitDataPhase(b,isError);
endtask
function uvm_bitstream_t RhAhb5MstConfig::getSignal(string signame);
	return ifCtrl.getSignal(signame);
endfunction
task RhAhb5MstConfig::waitCycle(int c=1);
	ifCtrl.sync(c);
endtask
task RhAhb5MstConfig::driveIdleBeat(int cycle=1,int os);
	RhAhb5TransBeat beat;
	sendAddressPhase(beat,os);
endtask
function  RhAhb5MstConfig::new(string name="RhAhb5MstConfig");
	super.new(name);
endfunction

`endif