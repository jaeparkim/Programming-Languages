package salsa.resources;

// Import declarations generated by the SALSA compiler, do not modify.
import java.io.IOException;
import java.util.Vector;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.lang.reflect.InvocationTargetException;

import salsa.language.Actor;
import salsa.language.ActorReference;
import salsa.language.Message;
import salsa.language.RunTime;
import salsa.language.ServiceFactory;
// End SALSA compiler generated import delcarations.

import salsa.language.Actor;
import salsa.language.Message;
import salsa.naming.UAN;
import salsa.naming.UAL;
import gc.SystemMessage;

public interface SystemService extends EnvironmentalService {
	public interface State extends EnvironmentalServiceState {
		public  void messageTargetNotFound(Message message);
                public  void messageTargetNotFound(SystemMessage message);
                public void createActor(UAN uan, UAL ual, String className, Object sourceRef);
                public void createActor(UAN uan, UAL ual, String className);
		public void removePlaceholder(UAN uan, UAL ual);
                public void addActor(byte[] actorBytes);

	}
}