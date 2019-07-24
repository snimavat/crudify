package grails.plugins.crudify

import grails.gorm.transactions.TransactionService
import grails.gorm.transactions.Transactional
import grails.web.Action

import static org.springframework.http.HttpStatus.OK

trait EditAction<T> implements CrudifyAction<T> {

	@Action
	def edit() {
		T instance = domainClass.get(params.id)
		if (request.method == "GET") {
			onEdit(instance)
			return
		}

		if (request.method == "POST") {
			bindData instance, getObjectToBind()
			instance.validate()
			if (instance.hasErrors()) {

				withFormat {
					form multipartForm {
						if(request.xhr) {
							render template("form", model: model(instance))
						}
						else {
							respond instance, view: view('edit'), model: model(instance)
						}
					}

					'*'{
						respond instance, view: view('edit'), model: model(instance)
					}

				}

				if(request.xhr) {
					respond instance, view: view('edit'), model: model(instance)
				} else {
					respond instance, view: view('edit'), model: model(instance)
				}
				return
			} else {
				domainClass.withTransaction {
					updateInstance(instance)
				}
				onUpdate(instance)
			}
		}
	}

	void onUpdate(T instance) {
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

	void onEdit(T instance) {
		withFormat {
			html {
				if(request.xhr) {
					render template: template("form"), model: model(instance)
				} else {
					respond instance, view: view("edit"), model: model(instance)
				}
			}
			'json'{
				respond instance, [status: OK]
			}
		}
	}

	void updateInstance(T instance) { instance.save() }

}