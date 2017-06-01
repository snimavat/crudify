package grails.plugins.crudify

import grails.web.Action

trait CreateAction<T> implements CrudifyAction<T> {

	@Action
	def create() {
		T instance = createInstance()
		if (request.method == "GET") {
			onCreate(instance)
			respond instance, view: "create", model: model(instance)
			return
		}

		if (request.method == "POST") {
			instance.validate()
			if (instance.hasErrors()) {
				respond instance, view: 'create', model: model(instance)
				return
			} else {
				domainClass.withTransaction {
					onSave(instance)
					saveInstance(instance)
				}
				redirect action: "list", params: [domainClass: params.domainClass]
			}

		}

	}

	void onSave(T instance) {}

	void onCreate(T instance) {}

	void saveInstance(T instance) { instance.save() }

}