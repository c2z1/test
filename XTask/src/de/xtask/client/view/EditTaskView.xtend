package de.xtask.client.view

import com.google.gwt.user.client.ui.DecoratorPanel
import com.google.gwt.user.client.ui.Composite
import com.google.gwt.user.client.ui.TextBox
import com.google.gwt.user.client.ui.FlexTable
import com.google.gwt.user.client.ui.VerticalPanel
import com.google.gwt.user.client.ui.Label
import com.google.gwt.user.client.ui.HorizontalPanel
import com.google.gwt.user.client.ui.Button
import de.xtask.client.presenter.EditTaskDisplay

class EditTaskView extends Composite implements EditTaskDisplay {
	val TextBox name
	val TextBox description
	val FlexTable detailsTable
	val Button saveButton
	val Button cancelButton

	new() {
		val contentDetailsDecorator = new DecoratorPanel();
		contentDetailsDecorator.setWidth("18em");
		initWidget(contentDetailsDecorator);

		val contentDetailsPanel = new VerticalPanel();
		contentDetailsPanel.setWidth("100%");

		// Create the contacts list
		//
		detailsTable = new FlexTable();
		detailsTable.setCellSpacing(0);
		detailsTable.setWidth("100%");
		detailsTable.addStyleName("contacts-ListContainer");
		detailsTable.getColumnFormatter().addStyleName(1, "add-contact-input");
		name = new TextBox();
		description = new TextBox();
		initDetailsTable();
		contentDetailsPanel.add(detailsTable);

		val menuPanel = new HorizontalPanel();
		saveButton = new Button("Save");
		cancelButton = new Button("Cancel");
		menuPanel.add(saveButton);
		menuPanel.add(cancelButton);
		contentDetailsPanel.add(menuPanel);
		contentDetailsDecorator.add(contentDetailsPanel);
	}

	def void initDetailsTable() {
		detailsTable.setWidget(0, 0, new Label("Name"));
		detailsTable.setWidget(0, 1, name);
		detailsTable.setWidget(1, 0, new Label("Beschreibung"));
		detailsTable.setWidget(1, 1, description);
		name.setFocus(true);
	}

	override getSaveButton() {
		return saveButton;
	}

	override getCancelButton() {
		return cancelButton;
	}

	override asWidget() {
		return this;
	}
	
	override getName() {
		return name
	}
	
	override getDescription() {
		description
	}

}
