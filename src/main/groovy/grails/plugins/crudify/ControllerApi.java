package grails.plugins.crudify;

import grails.web.servlet.mvc.GrailsParameterMap;
import org.springframework.validation.BindingResult;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by sudhir on 02/04/17.
 */
public interface ControllerApi {

	GrailsParameterMap getParams();
	BindingResult bindData(Object target, Object bindingSource);
	HttpServletRequest getRequest();
	void redirect(Map arg);
	void redirect(Object arg);
	Object respond(Map args, Object value);
	Object respond(Map value);
	Object respond(Object value, Map args);
	void render(Object arg);
}
