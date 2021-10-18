package salsa.resources;

/**
 * <p>Title: </p>
 * <p>Description: lock for synchronous access and unlock to release the resource</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: WWC</p>
 * @author WeiJen Wang
 * @version 1.0
 */

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



public interface InputService  extends EnvironmentalService{
  public interface State extends salsa.resources.EnvironmentalServiceState {
  }

}