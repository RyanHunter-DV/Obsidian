`ifndef rhAhb5MstDriver__svh
`define rhAhb5MstDriver__svh
/************************************************************************************/
// Author: RyanHunter
// Created: 2022-12-22 06:29:21 -0800
// Description:
// This file is automatically generated by MDC-v2, any issues found
// here should be modified in its source markdown document the same
// dir structure in Git/Obsidian/...
/************************************************************************************/

class RhAhb5MstDriver #( type REQ=RhAhb5ReqTrans,RSP=RhAhb5RspTrans) extends RhDriverBase#(REQ,RSP);
	uvm_analysis_port #(REQ) reqP;
	RhAhb5MstConfig config;
	RhAhb5TransBeat addressQue[$];
	RhAhb5TransBeat dataQue[$];
	int outstandingData;

	`uvm_component_utils_begin(RhAhb5MstDriver#(REQ,RSP))
	`uvm_component_utils_end
	extern task addressPhaseStart();
	extern task dataPhaseStart();
	extern task processDelay(input int cycle);
	extern task processError();
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task mainProcess();
	extern task seqProcessStart();
	extern local task __sendIdleBeat__();
	extern function void convertTransToBeats(REQ tr,ref RhAhb5TransBeat beat);
	extern function  new(string name="RhAhb5MstDriver",uvm_component parent=null);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
endclass
task RhAhb5MstDriver::addressPhaseStart();
	forever begin
		RhAhb5TransBeat beat;
		// wait(addressQue.size());
		while (addressQue.size()==0) begin
			__sendIdleBeat__;
			config.ifCtrl.clock();
		end
		beat = addressQue.pop_front();
		`rhudbg($sformatf("driving beat to address phase:\n%p",beat))
		// sendAddressPhase will wait high if outstanding>0, or will wait one
		// cycle if htrans!=0
		config.sendAddressPhase(beat,outstandingData);
		outstandingData++;
	end
endtask
task RhAhb5MstDriver::dataPhaseStart();
	forever begin
		RhAhb5TransBeat beat;
		bit isError;
		// wait(dataQue.size());
		while (dataQue.size()==0) begin
			beat.data='h0;
			config.sendDataPhase(beat,isError);
		end
		beat = dataQue.pop_front();
		config.sendDataPhase(beat,isError);
		if (isError) begin
			processError();
			outstandingData = 0;
		end else outstandingData--;
	end
endtask
task RhAhb5MstDriver::processDelay(input int cycle);
	config.waitCycle(cycle);
	// backup, bit processidle = 1'b0;
	// backup, if (outstandingData==0) `rhudbgCall("driving idle beat",__sendIdleBeat__())
	// backup, else processidle=1'b1;
	// backup, for (int i=0;i<cycle;i++) begin
	// backup, 	config.waitCycle(1);
	// backup, 	if (processidle) begin
	// backup, 		if (outstandingData==0) `rhudbgCall("driving idle beat",__sendIdleBeat__())
	// backup, 	end
	// backup, end
endtask
task RhAhb5MstDriver::processError();
	dataQue.delete();
	addressQue.delete();
	config.driveIdleBeat(1,outstandingData);
endtask
function void RhAhb5MstDriver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	outstandingData = 0;
	reqP=new("reqP",this);
endfunction
task RhAhb5MstDriver::mainProcess();
	fork
		seqProcessStart();
		addressPhaseStart();
		dataPhaseStart();
	join
endtask
task RhAhb5MstDriver::seqProcessStart();
	forever begin
		REQ _reqClone;
		RhAhb5TransBeat beat;
		seq_item_port.get_next_item(req);
		$cast(_reqClone,req.clone());
		processDelay(req.delay);
		convertTransToBeats(req,beat);
		`rhudbg($sformatf("sending exp trans to monitor:\n%s",_reqClone.sprint()))
		reqP.write(_reqClone);
		addressQue.push_back(beat);
		config.waitCycle();
		dataQue.push_back(beat);
		seq_item_port.item_done();
	end
endtask
// backup
// backup, task RhAhb5MstDriver::seqProcessStart();
// backup, 	forever begin
// backup, 		RhAhb5TransBeat beat;
// backup, 		REQ _reqClone;
// backup, 		seq_item_port.try_next_item(req);
// backup, 		if (req==null) begin
// backup, 			`rhudbgCall("driving idle beat",__sendIdleBeat__())
// backup, 			seq_item_port.get_next_item(req);
// backup, 		end
// backup, 		$cast(_reqClone,req.clone());
// backup, 		`rhudbg($sformatf("sending exp trans to monitor:\n%s",_reqClone.sprint()))
// backup, 		reqP.write(_reqClone); // send to monitor for self check
// backup, 		processDelay(req.delay);
// backup, 		// @RyanH,TODO, to be deleted, splitTransToBeats(req,beats);
// backup, 		// @RyanH,TODO, to be deleted, foreach (beats[i]) addressQue.push_back(beats[i]);
// backup, 		// @RyanH,TODO, to be deleted, wait (addressQue.size()==0); // only when this trans finished, can next coming in.
// backup, 	
// backup, 		// new added steps
// backup, 		convertTransToBeats(req,beat);
// backup, 		addressQue.push_back(beat);
// backup, 		// @RyanH wait(addressQue.size()==0);
// backup, 		// need wait at least one cycle before geting next sequence
// backup, 		config.waitCycle();
// backup, 		seq_item_port.item_done();
// backup, 	end
// backup, endtask
task RhAhb5MstDriver::__sendIdleBeat__();
	RhAhb5TransBeat beat;
	beat.burst = 0;
	beat.trans = 0;
	beat.write = 0;
	beat.data  = 0;
	beat.addr  = 0;
	beat.master= 0;
	beat.size  = 0;
	beat.lock  = 0;
	beat.prot  = 0;
	beat.nonsec= 0;
	beat.excl  = 0;
	// @RyanH assume this drive will not take any sim time.
	`rhudbg($sformatf("idle beat:\n%p",beat))
	config.sendAddressPhase(beat,0);
endtask
function void RhAhb5MstDriver::convertTransToBeats(REQ tr,ref RhAhb5TransBeat beat);
	// @RyanH beat.index = i;
	beat.burst = tr.burst;
	beat.trans = tr.trans;
	beat.write = tr.write;
	if (beat.write) beat.data = tr.wdata;
	beat.addr  = tr.addr;
	beat.master= tr.master;
	beat.size  = tr.size;
	beat.lock  = tr.lock;
	beat.prot  = tr.prot;
	beat.nonsec= tr.nonsec;
	beat.excl  = tr.excl;
endfunction
function  RhAhb5MstDriver::new(string name="RhAhb5MstDriver",uvm_component parent=null);
	super.new(name,parent);
endfunction
function void RhAhb5MstDriver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction
task RhAhb5MstDriver::run_phase(uvm_phase phase);
	super.run_phase(phase);
endtask
// backup, task RhAhb5MstMonitor::waitReadyHigh();
// backup, 	bit done=1'b0;
// backup, 	while (!done) begin
// backup, 		// done = (config.getSignal("HREADY")[0]==1'b1)? 1'b1 : 1'b0;
// backup, 		done = (config.ifCtrl.HREADY===1'b1)? 1'b1 : 1'b0;
// backup, 		config.ifCtrl.clock();
// backup, 	end
// backup, endtask

`endif
