package de.gwtannotations

import java.util.List
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.TransformationParticipant
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclarationimport org.eclipse.xtend.lib.macro.RegisterGlobalsParticipant
import org.eclipse.xtend.lib.macro.declaration.ClassDeclaration
import org.eclipse.xtend.lib.macro.RegisterGlobalsContext
import org.eclipse.xtend.lib.macro.declaration.Visibility

@Active(typeof(GwtEventProcessor))
annotation GwtEvent {
	
}

class GwtEventProcessor implements TransformationParticipant<MutableClassDeclaration>,
	RegisterGlobalsParticipant<ClassDeclaration> {
	
	override doTransform(List<? extends MutableClassDeclaration> classes, extension TransformationContext context) {
		classes.forEach [cl|
			val intface = context.findInterface(cl.handlerName)
			intface.setExtendedInterfaces(#[context.newTypeReference('com.google.gwt.event.shared.EventHandler')])
			intface.addMethod(cl.onActionMethodName, [
				abstract = true
				addParameter("event", context.newTypeReference(cl))
			])
			
			val interfaceRef = context.newTypeReference(intface)
			val typeTypeRef = context.newTypeReference('com.google.gwt.event.shared.GwtEvent$Type', interfaceRef)
			
			cl.setExtendedClass(context.newTypeReference('com.google.gwt.event.shared.GwtEvent', interfaceRef))
			
			cl.addField('TYPE') [
				type = typeTypeRef
				static = true
				visibility = Visibility::PUBLIC
				it.initializer = ['''new Type<«interfaceRef.simpleName»>();''']
			]
			
			cl.addMethod('dispatch') [
				visibility = Visibility::PROTECTED
				addParameter('handler', interfaceRef)
				body = ['''
					handler.«cl.onActionMethodName»(this);''']
			]
			cl.addMethod('getAssociatedType') [
				visibility = Visibility::PUBLIC
				returnType = typeTypeRef
				body = ['''
					return TYPE;''']
			]
		]
	}
	
	def getOnActionMethodName(MutableClassDeclaration cl) {
		"on" + cl.baseName
	}
	
	override doRegisterGlobals(List<? extends ClassDeclaration> annotatedSourceElements, 
			RegisterGlobalsContext context) {
		annotatedSourceElements.forEach [cl|
				context.registerInterface(cl.handlerName)
			]
	}
	
	def getHandlerName(ClassDeclaration cl) {
		cl.qualifiedName + "Handler"
	}
	
	def getBaseName(ClassDeclaration cl) {
		val name = cl.simpleName
		if (name.endsWith("Event")) cl.simpleName.substring(0, name.length-5)
		else name
	}
	
}