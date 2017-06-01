package grails.plugins.crudify;

import groovy.transform.CompileStatic;

import java.util.HashMap;
import java.util.Map;

@CompileStatic
public interface CrudifyAction<T> extends ControllerApi {

	abstract Class<T> getDomainClass();

	default T createInstance() throws IllegalAccessException, InstantiationException {
		T instance = getDomainClass().newInstance();
		bindData(instance, getObjectToBind());
		return instance;
	};


	default Object getObjectToBind() {
		return getRequest();
	}

	default Map model(T instance) {
		Map model = new HashMap();
		model.put("instance", instance);
		model.putAll(extranModel(instance));
		return model;
	}

	default Map extranModel(T instance) { return new HashMap(); }

}
