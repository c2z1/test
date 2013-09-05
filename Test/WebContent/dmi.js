		Date.prototype.addHours = function(h) {
			var ret = new Date()
			ret.setTime(this.getTime() + (h*60*60*1000)); 
			return ret;   
		}
		Wochentag = new Array("Sonntag", "Montag", "Dienstag", "Mittwoch",
                          "Donnerstag", "Freitag", "Samstag");
						  
		var actualImageNo = 0;
		
		var lastRefresh;
		
		var FirstImgDelay = 6;
		var ImageCount = 49;
		var SliderPartWidth = 13;
		var lastSliderPos = -1;
		
		var SliderPartName = "sliderpart";
		
		var displayCallback;
		
		function init(startCallback, displCallback) {
			displayCallback = displCallback
			initSlider();
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
			initLastRefreshAndDisplay(now.addHours(-hours-6), startCallback);
			
		}

		function initLastRefreshAndDisplay(date, startCallback) {
			var nextVal = date.addHours(6)
			img = new Image()
			img.onload = function() {
				setLastRefresh(nextVal)
				startCallback()
			}
			img.onerror = function() {
				initLastRefreshAndDisplay(date.addHours(-6))
			}
			img.src = imageLink("Wind", nextVal, getDate(nextVal, actualImageNo))
		}
		
		function initSlider() {
			for (var i = 0; i < ImageCount; i++) {
				var div = document.createElement("div");
				div.className = SliderPartName;
				div.style.width = SliderPartWidth + "px";
				div.id = "" + i
				div.onmouseover = function() {
					var nr = parseInt(this.id);
					setActImage(nr);
				}
				div.ontouchmove = function(e) {
					var imgNo = e.touches[0].screenX / SliderPartWidth
					setActImage(imgNo.toFixed() - 1)
					e.stopPropagation()
					e.preventDefault()
				}
				document.getElementById('navslider').appendChild(div);
			}
		}
		function displaySliderPos(imgNo) {
			if (lastSliderPos >= 0) {
				getSliderPart(lastSliderPos).style.backgroundColor="#aaa"
			}
			getSliderPart(imgNo).style.backgroundColor="#555"
			lastSliderPos = imgNo;
		}
		
		function getSliderPart(no) {
			return document.getElementById("" + no)
		}
		
		function setActImage(nr) {
			if (nr != actualImageNo) {
	//			print('image ' + nr)
				actualImageNo = nr
				displayCallback();
			}
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
			return "http://www.dmi.dk/fileadmin/SeaForecast/vestlige_osterso/" + type 
					+ "." + dateUrlStr(refreshDate) + "." + dateUrlStr(imgDate) + ".png"
		}
		
		function getDate(refreshDate, imgNo) {
			return refreshDate.addHours(FirstImgDelay + imgNo)
		}
		
		function nextImage(count) {
//			print('next: ' + count)
			setActImage(actualImageNo + count)
		}
		
		function dateDisplStr(date) {
			return date.getDate() + "." + (date.getMonth()+1) + "." + (date.getFullYear()) + " - " 
					+ date.getHours() + ":00"
		}
		
		function display() {
			displaySliderPos(actualImageNo)
			var imgDate = getDate(lastRefresh, actualImageNo)
			document.getElementById("Wind").src = imageLink("Wind", lastRefresh, imgDate)
			document.getElementById("WindDirection").src = imageLink("WindDirection", lastRefresh, imgDate)
			displLabel(imgDate)
		}
		
		function displayLabel() {
			displLabel(getDate(lastRefresh, actualImageNo))
		}
		function displLabel(imgDate) {
			var displayDate = imgDate.addHours(2)
			document.getElementById("datelabel").innerHTML = Wochentag[displayDate.getDay()] + ", "
			+ dateDisplStr(displayDate) + "   "
		}
		
		function preloadImage(imgNo) {
			var tmpDate = getDate(lastRefresh, i)
			new Image().src = imageLink("Wind", lastRefresh, tmpDate)
			new Image().src = imageLink("WindDirection", lastRefresh, tmpDate)
		}
		
		function loadAllImages() {
			for (var i = 1; i <= ImageCount; i++) {
				preload(i)
			}
		}
		
		function getFirstImgDate() {
			return lastImage.addHours(-ImageCount)
		}
		
		function setLastRefresh(val) {
			lastRefresh = val
			document.getElementById("refreshDateBtn").value = lastRefresh.getHours() + ":00"
		}
		
		function testRefresh() {
 			var newRefresh = lastRefresh.addHours(6)
			var img = new Image()
			img.onload = function() {
				setLastRefresh(newRefresh)
				displayCallback()
			}
			img.src = imageLink("Wind", newRefresh, getDate(lastRefresh, actualImageNo))
		}
		
		function print(str) {
			document.getElementById("print").innerHTML = document.getElementById("print").innerHTML + "<br>" + str
		}
