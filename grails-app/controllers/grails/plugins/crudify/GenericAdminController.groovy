package grails.plugins.crudify

import grails.core.GrailsApplication
import grails.core.GrailsClass
import grails.web.controllers.ControllerMethod
import org.grails.core.artefact.DomainClassArtefactHandler

class GenericAdminController implements CrudController {
	static namespace = "admin"
	static defaultAction = "list"
	AdminViewsService adminViewsService

	GrailsApplication grailsApplication

	def index() {
		redirect action:"list", params:params
	}

	@Override
	@ControllerMethod
	Class getDomainClass() {
		Class domainClass
		if(request['domainClass']) return request['domainClass']
		else {
			GrailsClass clazz = grailsApplication.getArtefactByLogicalPropertyName(DomainClassArtefactHandler.TYPE, params.domainClass)
			if(clazz == null || clazz.clazz == null) throw new NotFoundException()
			domainClass = clazz.clazz
			request['domainClass'] = domainClass
		}
	}

	def handleNotFoundException(NotFoundException e) {
		render status:404
	}
}


