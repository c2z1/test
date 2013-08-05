package de.xtask.client.view

import com.google.gwt.event.dom.client.ClickEvent
import com.google.gwt.user.client.ui.Button
import com.google.gwt.user.client.ui.CheckBox
import com.google.gwt.user.client.ui.Composite
import com.google.gwt.user.client.ui.DecoratorPanel
import com.google.gwt.user.client.ui.DockPanel
import com.google.gwt.user.client.ui.FlexTable
import com.google.gwt.user.client.ui.HorizontalPanel
import com.google.gwt.user.client.ui.Widget
import de.xtask.client.presenter.TasksDisplay
import java.util.List

class TasksView extends Composite implements TasksDisplay {
	private final Button addButton
	private final Button deleteButton
	private FlexTable contactsTable
	private final FlexTable contentTable

	new() {
		val contentTableDecorator = new DecoratorPanel()
		initWidget(contentTableDecorator)
		contentTableDecorator.setWidth("100%")
		contentTableDecorator.setWidth("18em")

		contentTable = new FlexTable()
		contentTable.setWidth("100%")
		contentTable.getCellFormatter().addStyleName(0, 0, "tasks-ListContainer")
		contentTable.getCellFormatter().setWidth(0, 0, "100%")
		contentTable.getFlexCellFormatter().setVerticalAlignment(0, 0, DockPanel::ALIGN_TOP)

		// Create the menu
		//
		val hPanel = new HorizontalPanel()
		hPanel.setBorderWidth(0)
		hPanel.setSpacing(0)
		hPanel.setHorizontalAlignment(HorizontalPanel::ALIGN_LEFT)
		addButton = new Button("Add")
		hPanel.add(addButton)
		deleteButton = new Button("Delete")
		hPanel.add(deleteButton)
		contentTable.getCellFormatter().addStyleName(0, 0, "tasks-ListMenu")
		contentTable.setWidget(0, 0, hPanel)

		// Create the contacts list
		//
		contactsTable = new FlexTable()
		contactsTable.setCellSpacing(0)
		contactsTable.setCellPadding(0)
		contactsTable.setWidth("100%")
		contactsTable.addStyleName("tasks-ListContents")
		contactsTable.getColumnFormatter().setWidth(0, "15px")
		contentTable.setWidget(1, 0, contactsTable)

		contentTableDecorator.add(contentTable)
	}

	override getAddButton() {
		return addButton
	}

	override getDeleteButton() {
		return deleteButton
	}

	override getList() {
		return contactsTable
	}

	override setData(List<String> data) {
		contactsTable.removeAllRows()

		for (i : 0 ..< data.size) {
			contactsTable.setWidget(i, 0, new CheckBox())
			contactsTable.setText(i, 1, data.get(i))
		}
	}

	override int getClickedRow(ClickEvent event) {
		var selectedRow = -1
		val cell = contactsTable.getCellForEvent(event)

		if (cell != null) {

			// Suppress clicks if the user is actually selecting the 
			//  check box
			//
			if (cell.getCellIndex() > 0) {
				selectedRow = cell.getRowIndex()
			}
		}

		return selectedRow
	}

	override List<Integer> getSelectedRows() {
		val selectedRows = newArrayList

		for (i : 0 ..< contactsTable.getRowCount()) {
			val checkBox = contactsTable.getWidget(i, 0) as CheckBox
			if (checkBox.getValue()) {
				selectedRows.add(i)
			}
		}

		return selectedRows
	}

	override Widget asWidget() {
		return this
	}
}
