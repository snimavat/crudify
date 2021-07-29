package grails.plugins.crudify

import grails.gorm.PagedResultList
import grails.plugins.crudify.core.Pager
import grails.web.Action
import groovy.transform.CompileStatic
import org.codehaus.groovy.runtime.InvokerHelper
import org.grails.datastore.gorm.GormEntity
import org.grails.datastore.mapping.query.api.BuildableCriteria

trait ListAction<T> implements CrudifyAction<T> {

	List<T> listCriteria() {
		Class d = domainClass
		Pager pager = new Pager(params)
		BuildableCriteria criteria = (BuildableCriteria)InvokerHelper.invokeStaticMethod(d, "createCriteria", null)
		return (List)criteria.list(max:pager.max, offset:pager.offset){}
	}

	@Action
	def list() {
		List<T> list = listCriteria()
		Map resp = listModel(list)
		if(request.xhr) {
			render template: template('list'), model: resp
		} else {
			respond resp, view: view('list'), model: resp
		}
	}

	Map listModel(List list) {
		int total = list instanceof PagedResultList ? list.totalCount : list.size()
		return [list:list, total:total]
	}

	@Action
	def filter() {
		PagedResultList<T> list = listCriteria()
		Map resp = [list:list, total:list.totalCount]
		render template: template("rows"), model:resp
	}

}