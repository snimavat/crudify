package grails.plugins.crudify

import grails.web.Action

import static org.springframework.http.HttpStatus.OK

trait CreateAction<T> implements CrudifyAction<T> {

	@Action
	def create() {
		def data = getObjectToBind()
		T instance = createInstance(data)
		if (request.method == "GET") {
			onCreate(instance)
			return
		}

		if (request.method == "POST") {
			instance.validate()
			if (instance.hasErrors()) {
				onValidationError(instance)
				return
			} else {
				domainClass.withTransaction {
					saveInstance(instance, data)
				}
				onSave(instance)
			}

		}

	}

	void onSave(T instance) {
		withFormat {
			html {
				if(request.xhr) {
					render status: 204
				} else {
					redirect action: "list", params: [domainClass: params.domainClass]
				}
			}
			'json'{
				respond instance, [status: OK]
			}
		}

	}

	void onCreate(T instance) {
		withFormat {
			html {
				if(request.xhr) {
					render template: template("form"), model: model(instance)
				} else {
					respond instance, view: view("create"), model: model(instance)
				}
			}
			'json'{
				respond instance, [status: OK]
			}
		}
	}

	void onValidationError(T instance) {
		respond instance, view: view('create'), model: model(instance)
	}

	void saveInstance(T instance, Object data) { instance.save() }

}