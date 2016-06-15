package call.mat.demo;

import matlabcontrol.MatlabConnectionException;
import matlabcontrol.MatlabInvocationException;
import matlabcontrol.MatlabProxy;
import matlabcontrol.MatlabProxyFactory;

public class SinglarCallMatlab {

	public static void main(String[] args) {
		
		String val = "0.0001	0.0001	0.0001	0.0001	5	2";
		System.out.println("value: " + val);
		val = val.replaceAll("\t", ",");

		try {

			// Create a proxy, which we will use to control MATLAB
			MatlabProxyFactory factory = new MatlabProxyFactory();
			MatlabProxy proxy = factory.getProxy();
			proxy.eval("main_ParemeterChoose(" + val + ")");

			// Disconnect the proxy from MATLAB
			proxy.exit();
			proxy.disconnect();

		} catch (MatlabConnectionException | MatlabInvocationException e) {
			e.printStackTrace();
		}

	}

}
