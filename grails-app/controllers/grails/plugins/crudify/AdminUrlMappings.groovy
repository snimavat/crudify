package grails.plugins.crudify

/**
 * Created by sudhir on 12/03/17.
 */
class AdminUrlMappings {

	static mappings = {

		"/admin/$domainClass/$action?/$id?(.$format)?" {
			controller = "genericAdmin"
			namespace = "admin"
		}
	}
}
