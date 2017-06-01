package grails.plugins.crudify

import grails.gorm.PagedResultList
import grails.web.Action
import groovy.transform.CompileStatic
import org.codehaus.groovy.runtime.InvokerHelper
import org.grails.datastore.gorm.GormEntity
import org.grails.datastore.mapping.query.api.BuildableCriteria

trait ListAction<T> implements CrudifyAction<T> {

	PagedResultList<T> listCriteria() {
		Class d = domainClass
		BuildableCriteria criteria = (BuildableCriteria)InvokerHelper.invokeStaticMethod(d, "createCriteria", null)
		return (List)criteria.list(max:params.max, offset:params.offset){}
	}

	@Action
	def list() {
		PagedResultList<T> list = listCriteria()
		Map resp = [list:list, total:list.totalCount]
		respond resp
	}

	@Action
	def filter() {
		PagedResultList<T> list = listCriteria()
		Map resp = [list:list, total:list.totalCount]
		render template:"list", model:resp

	}

}