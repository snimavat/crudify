package grails.plugins.crudify.core

import grails.web.servlet.mvc.GrailsParameterMap
import groovy.transform.CompileStatic

@CompileStatic
class Pager {
	int max
	int page
	int offset

	Pager(GrailsParameterMap params, int defaultMax = 10, int allowedMax = 100) {
		max = (int) Math.min((params.max != null ? params.int("max") : defaultMax ), allowedMax)
		if(params.int("offset") != null) {
			offset = params.int("offset")
		} else if (params.int("page") != null) {
			offset = (max * (params.int("page") - 1))
		}

		offset = offset ?: 0
	}
}
