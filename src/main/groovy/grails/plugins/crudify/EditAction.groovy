package grails.plugins.crudify

import grails.web.Action

trait EditAction<T> implements CrudifyAction<T> {

	@Action
	def edit() {
		T instance = domainClass.get(params.id)
		if (request.method == "GET") {
			onEdit(instance)
			respond instance, view: "edit", model: model(instance)
			return
		}

		if (request.method == "POST") {
			bindData instance, getObjectToBind()
			instance.validate()
			if (instance.hasErrors()) {
				respond instance, view: 'edit', model: model(instance)
				return
			} else {
				domainClass.withTransaction {
					onUpdate(instance)
					updateInstance(instance)
				}
				redirect action: "list", params: [domainClass: params.domainClass]
			}
		}
	}

	void onUpdate(T instance) {}

	void onEdit(T instance) {}

	void updateInstance(T instance) { instance.save() }

}