package grails.plugins.crudify

import org.apache.commons.lang.StringUtils
import org.grails.web.gsp.io.GrailsConventionGroovyPageLocator

import static org.grails.io.support.GrailsResourceUtils.appendPiecesForUri

/**
 * Provides view/template lookup for GenericAdmin controller.
 * Makes it possible to override specific view/template inside grails-app/views/domain/viewname.gsp
 */
class AdminViewsService {
     GrailsConventionGroovyPageLocator groovyPageLocator

     String view(String name, Class domain) {
        String controller = domain.getSimpleName()
        controller = StringUtils.uncapitalize(controller)

        List<String> templateResolveOrder = []
        templateResolveOrder << (appendPiecesForUri("/admin", controller, name));
        //templateResolveOrder.add(appendPiecesForUri("/admin", "genericAdmin", name));

        return findView(templateResolveOrder) ?: name
    }


    String template(String name, Class domain) {
        String controller = domain.getSimpleName()
        controller = StringUtils.uncapitalize(controller)

        List<String> templateResolveOrder = []
        templateResolveOrder << (appendPiecesForUri("/admin", controller, name));
        //templateResolveOrder.add(appendPiecesForUri("/admin", "genericAdmin", name));
        return findTemplate(templateResolveOrder) ?: name
    }


    private String findView(List<String> candidates) {
        String path = candidates.findResult { String path ->
            def source = groovyPageLocator.findViewByPath(path)
            if(source) return path
            else return null
        }

        return path
    }

    private String findTemplate(List<String> candidates) {
        String path = candidates.findResult { String path ->
            def source = groovyPageLocator.findTemplateByPath(path)
            if(source) return path
            else return null
        }

        return path
    }
}
