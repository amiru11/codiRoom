package com.basic.freeboard;

import com.basic.board.BoardDTO;

public class FreeboardDTO extends BoardDTO{

	private int ref;
	private int step;
	private int depth;
	
	
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	
	
	
}
