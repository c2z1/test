package de.test

import javax.swing.JButton
import javax.swing.JFrame
import javax.swing.SwingUtilities
import javax.swing.JOptionPane
import javax.swing.JComponent
import java.awt.Component

class Main {
	def static void main(String[] args) {

		SwingUtilities.invokeLater[|openFrame()]		
	}
	
	def static openFrame() {
		new JFrame("Title") => [
			val frame = it
			setVisible(true)
			add(new JButton("Test") => [addActionListener[e|openDialog(frame)]])
			setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
			pack()
		]
	}
	
	def static openDialog(Component comp) {
		JOptionPane.showMessageDialog(comp, "Message", "Gaaaaaaanz laaaaaanger Tiiiiiiitel", JOptionPane.INFORMATION_MESSAGE)
	}
	
}