		Date.prototype.addHours = function(h) {    
			this.setTime(this.getTime() + (h*60*60*1000)); 
			return this;   
		}
		Date.prototype.copy = function() {
			ret = new Date()
			ret.setTime(this.getTime()); 
			return ret;   
		}
		Wochentag = new Array("Sonntag", "Montag", "Dienstag", "Mittwoch",
                          "Donnerstag", "Freitag", "Samstag");
						  
		var actualImageDate;
		
		var lastRefresh;
		
		var lastImage;
		
		var FirstImgDelay = 8;
		var ImageCount = 49;
		var SliderPartWidth = 13;
		
		function init() {
			initActualImageDate();
			
			var now = new Date()
			var hours = now.getHours();
			if (hours < 2) {
				hours = hours + 12;
			} else 
			if (hours >= 2 && hours < 8) {
				hours = hours + 6;
			} else 
			if (hours >= 14 && hours < 20) {
				hours = hours - 6;
			} else 
			if (hours >= 20) {
				hours = hours - 12;
			}
			initLastRefreshAndDisplay(now.addHours(-hours-6));
			
			initSlider();
		}

		function initLastRefreshAndDisplay(date) {
			var nextVal = date.copy().addHours(6)
			img = new Image()
			img.onload = function() {
				setLastRefresh(nextVal)
				display()
			}
			img.onerror = function() {
				initLastRefreshAndDisplay(date.addHours(-6))
			}
			img.src = imageLink("Wind", nextVal, actualImageDate)
		}
		
		function initSlider() {
			for (var i = 0; i < ImageCount; i++) {
				var div = document.createElement("div");
				div.className = "sliderpart";
				div.style.width = SliderPartWidth + "px";
				div.id = i;
				div.onmouseover = function() {
					this.style.backgroundColor="#555";
					var nr = parseInt(this.id);
					setActImage(nr);
				}
				div.onmouseout = function() {
					this.style.backgroundColor="#aaa";
				}
				div.ontouchstart = function(e) {
					var imgNo = e.touches[0].screenX / SliderPartWidth
					setActImage(imgNo)
					e.stopPropagation()
					e.preventDefault()
				}
				document.getElementById('navslider').appendChild(div);
			}
			document.body.appendChild(docFrag);
		}
		
		function setActImage(nr) {
			actualImageDate = lastImage.copy();
			actualImageDate.addHours(-(ImageCount-nr));
			display();
		}
		
		function initActualImageDate() {
			actualImageDate = new Date();
			actualImageDate.setMilliseconds(0);
			actualImageDate.setSeconds(0);
			actualImageDate.setMinutes(0);
		}
		
		function zweistellig(zahl) {
			if (zahl > 9) return "" + zahl 
			else return "0" + zahl
		}
		
		function dateUrlStr(dateParam) {
			return dateParam.getFullYear() + zweistellig(dateParam.getMonth()+1) 
					+ zweistellig(dateParam.getDate()) + "_" + zweistellig(dateParam.getHours()) + "00"
		}
		
		function imageLink(type, refreshDate, imgDate) {
			if (imgDate > lastImage) {
				
			}
			adjustedImageDate = imgDate.copy().addHours(-2)
			return "http://www.dmi.dk/fileadmin/SeaForecast/vestlige_osterso/" + type 
					+ "." + dateUrlStr(refreshDate) + "." + dateUrlStr(adjustedImageDate) + ".png"
		}
		
		function nextImage(count) {
			actualImageDate.addHours(count)
			if (actualImageDate > lastImage) {
				initActualImageDate()
			}
			display()
		}
		
		function dateDisplStr(date) {
			return date.getDate() + "." + (date.getMonth()+1) + "." + (date.getFullYear()) + " - " 
					+ date.getHours() + ":00"
		}
		
		function display() {
			document.getElementById("Wind").src = imageLink("Wind", lastRefresh, actualImageDate)
			document.getElementById("WindDirection").src = imageLink("WindDirection", lastRefresh, actualImageDate)
			document.getElementById("datelabel").innerHTML = Wochentag[actualImageDate.getDay()] + ", "
					+ dateDisplStr(actualImageDate) + "   "
			// scrollbar aktualisiseren
		}
		
		function preloadImage(tmpDate) {
			if (tmpDate <= lastImage) {
				img = new Image()
				img.src = imageLink("Wind", lastRefresh, tmpDate)
				img = new Image()
				img.src = imageLink("WindDirection", lastRefresh, tmpDate)
			}
		}
		
		/*function preloadNext(count) {
			var tmpDate = actualImageDate.copy()
			for (var i = 1; i <= count; i++) {
				tmpDate.addHours(1)
				preload(tmpDate)
			}
		}*/
		
		function loadAllImages() {
			var tmpDate = getFirstImageDate()
			for (var i = 1; i <= ImageCount; i++) {
				tmpDate.addHours(1)
				preload(tmpDate)
			}
		}
		
		function getFirstImgDate() {
			return lastImage.copy().addHours(-ImageCount)
		}
		
		function setLastRefresh(val) {
			lastRefresh = val
			lastImage = lastRefresh.copy().addHours(FirstImgDelay + ImageCount)
			document.getElementById("refreshDateBtn").value = lastRefresh.getHours() + ":00"
		}
		
		function testRefresh() {
 			var newRefresh = lastRefresh.copy().addHours(6)
			img = new Image()
			img.onload = function() {
				setLastRefresh(newRefresh)
				display()
			}
			img.src = imageLink("Wind", newRefresh, actualImageDate)
		}
		
		function print(str) {
			document.getElementById("print").innerHTML = document.getElementById("print").innerHTML + "<br>" + str
		}
