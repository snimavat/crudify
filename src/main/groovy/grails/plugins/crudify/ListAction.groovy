package grails.plugins.crudify

import grails.gorm.PagedResultList
import grails.plugins.crudify.core.Pager
import grails.web.Action
import groovy.transform.CompileStatic
import org.codehaus.groovy.runtime.InvokerHelper
import org.grails.datastore.gorm.GormEntity
import org.grails.datastore.mapping.query.api.BuildableCriteria

trait ListAction<T> implements CrudifyAction<T> {

	PagedResultList<T> listCriteria() {
		Class d = domainClass
		Pager pager = new Pager(params)
		BuildableCriteria criteria = (BuildableCriteria)InvokerHelper.invokeStaticMethod(d, "createCriteria", null)
		return (List)criteria.list(max:pager.max, offset:pager.offset){}
	}

	@Action
	def list() {
		PagedResultList<T> list = listCriteria()
		Map resp = [list:list, total:list?.totalCount ?: 0]
		if(request.xhr) {
			render template: template('list'), model: resp
		} else {
			respond resp, view: view('list'), model: resp
		}
	}

	@Action
	def filter() {
		PagedResultList<T> list = listCriteria()
		Map resp = [list:list, total:list.totalCount]
		render template: template("rows"), model:resp
	}

}