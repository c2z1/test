package de.test

import java.awt.Component
import javax.swing.JButton
import javax.swing.JFrame
import javax.swing.JOptionPane
import javax.swing.SwingUtilities

class Main {
	def static void main(String[] args) {

		SwingUtilities.invokeLater[|openFrame()]		
	}
	
	def static openFrame() {
		new JFrame("Tiitle") => [
			val frame = it
			setVisible(true)
			add(new JButton("Test") => [addActionListener[e|openDialog(frame)]])
			setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
			pack()
		]
	}
	
	def static openDialog(Component comp) {
		JOptionPane.showMessageDialog(comp, "Messsdage", "Gaaaaaaanz laaaaaanger Tiiiiiiitel", JOptionPane.INFORMATION_MESSAGE)
	}
	
}