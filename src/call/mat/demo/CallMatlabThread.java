package call.mat.demo;

import matlabcontrol.MatlabConnectionException;
import matlabcontrol.MatlabInvocationException;
import matlabcontrol.MatlabProxy;
import matlabcontrol.MatlabProxyFactory;

class CallMatlabThread extends Thread {
	   private String threadName;
	   
	   CallMatlabThread( String name){
	       threadName = name;
	   }
	   public void run() {

		    System.out.println("value: " + threadName);
			String val = threadName.replaceAll("\t", ",");
			
			try {
				
				//Create a proxy, which we will use to control MATLAB 
				MatlabProxyFactory factory = new MatlabProxyFactory(); 
				MatlabProxy proxy = factory.getProxy();
				proxy.eval("main_ParemeterChoose("+val+")");

				//Disconnect the proxy from MATLAB
				proxy.exit();
				proxy.disconnect();
				
			} catch (MatlabConnectionException | MatlabInvocationException e) {
				e.printStackTrace();
			}
	   }
	}

