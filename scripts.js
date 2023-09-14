// JavaScript Document

//-- Page menu and repo scripts --

 // Changed with make tool
 var cur_test_results = "https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/";

 // Global elements.
 var navList = document.getElementById("navList");
 var navListATags = navList.getElementsByTagName("a");
 var dataCheck = document.querySelectorAll("[data-check]");
 var theDropDowns = document.querySelectorAll("[data-status]");  
 var globalNestedDropdown = document.getElementsByClassName("nestedDropdown");
 var dataConversionTestPageContent = document.getElementById("dataConversionTestPageContent");
 var dataNestCheck;

 // Change the command name in toggle
 var menuCommand, changeCurInnerHTML;
 function changeToggleMenu(file, curMenu) {
  let curToggleMenu = document.getElementById(curMenu);
  let curInnerHTML = curToggleMenu.innerHTML;
  if (menuCommand == undefined) {
   var xhttpCommand = new XMLHttpRequest();
   xhttpCommand.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     menuCommand = this.responseText;     
     changeCurInnerHTML = curInnerHTML.replace("CHANGE_COMMAND", menuCommand);
     curToggleMenu.innerHTML = changeCurInnerHTML;
    }
   };
   xhttpCommand.open("GET", file, true);
   xhttpCommand.send();
  } else {
   curToggleMenu.innerHTML = changeCurInnerHTML;
  }
 }
 changeToggleMenu("support/COMMAND-USED.txt", "source-label-html");
 changeToggleMenu("support/COMMAND-USED.txt", "pull-label-html");

 // Toggle the repo used for html links.
 var toggleDataCheck = function(ind) { 
  if (typeof ind == "number") {
   dataCheck[ind].dataset.check = "0"; 
   dataCheck[ind].previousElementSibling.removeAttribute("checked"); 
  } else {
/*   if (ind == "a") {    
    dataNestCheck[1].dataset.nestCheck = "0";
    dataNestCheck[1].dataset.showhide = "0";
   } else {
    dataNestCheck[0].dataset.nestCheck = "0";
    dataNestCheck[0].dataset.showhide = "0";    
   }*/
    for (i = 0; i < dataNestCheck.length; i++) {
     if (i.toString() != ind) {
      dataNestCheck[i].dataset.nestCheck = "0";
      dataNestCheck[i].dataset.showhide = "0";   
     }
    }
  }
 };
 // Subtle repo switch indicator.
 var indicateSwitch = function() {
  let ind = 0;
  var runInd = function() {
   for (let i = 0; i < globalNestedDropdown.length; i++) {
    let indClass = globalNestedDropdown[i].className;
    if (ind == 0 ) {
     globalNestedDropdown[i].className += " indicateSwitch"; // stylel with css
    } else {
     globalNestedDropdown[i].className = indClass.replace(" indicateSwitch", "");
    }
   }
  };
  runInd(); ind = 1; setTimeout(runInd, 500);
 };
 var sourceIsSet = 0;
 // Set source repo to selected repo for pages in dropdown.
 function setSource(cur, refSource) {
  if (refSource == undefined) { refSource = "source"; }
   let navListATagsLen = navListATags.length; let curHref;
   if (cur != undefined) {
    let checkStatus = cur.dataset.check;
    if (cur.nextElementSibling == null) { toggleDataCheck(0); }
    else { toggleDataCheck(1); }

    if (checkStatus == "0") { 
     cur.dataset.check = "1"; 
     cur.previousElementSibling.setAttribute("checked", true);
    } 
     else { 
      cur.dataset.check = "0";
      cur.previousElementSibling.setAttribute("checked", true);
     }
   }
   for (let i = 0; i < navListATagsLen; i++) {
    curHref = navListATags[i].href;
    if (sourceIsSet == 0) {
     navListATags[i].href = curHref.replace("COMMAND_USED", refSource);
    } else {
     if (refSource == "pull") {
      navListATags[i].href = curHref.replace("source", refSource);
     } else {
      navListATags[i].href = curHref.replace("pull", refSource);
     }
    }
   }
  if (sourceIsSet == 1) { indicateSwitch(); }
  sourceIsSet = 1;
 }

 // Make dropdowns by command options.
 function commandOptionDropdown(opts) {
  let dropLi = navList.getElementsByTagName("li");
  let dropLiLen = dropLi.length;
  let optUsed, textToArr, textToArrLen;
  let optHttp = new XMLHttpRequest();

  optHttp.onreadystatechange = function() {
   if (this.readyState == 4 && this.status == 200) {
    optUsed = this.responseText;
    textToArr = optUsed.split("\n");     
    textToArrLen = textToArr.length;
    for (i = 0; i < dropLiLen; i++) {
     let dropDiv = dropLi[i].getElementsByClassName("dropdown");
     for (ii = 0; ii < textToArrLen; ii++) {
      if (textToArr[ii] != "") {
       dropDiv[0].innerHTML += '     <div>\n' +
        '      <span class="pageDrop" data-nest-check="0" onclick="changeNextElementDisplay(this, \n' + 
        '       this.nextElementSibling); resetDropDowns(this, this.dataset.nestCheck, this.dataset.optIndex);" \n' +
        '       data-opt-index="'+ii+'">' +
        textToArr[ii] + '</span>\n' +
        '      <div class="dropdown nestedDropdown" style="display:none"></div>\n' +
        '     </div><br>';
       }
     }
    }     
   }
  };
  optHttp.open("GET", opts, true);
  optHttp.send();
 } 
 commandOptionDropdown("support/options-ran.txt");  

 // Show and hide nested dropdowns.
 function resetDropDowns(cur, curStatus, optIndex) {
  let curnestedDropdown = cur.nextElementSibling;
  let curData = cur.dataset;   
  let theCurStatus = curStatus;

  let theDropDownsLen = theDropDowns.length;
  // not a nested dropdown
  if (curnestedDropdown.className.indexOf("nestedDropdown") == -1) {
   dataNestCheck = document.querySelectorAll("[data-nest-check]");
   let dataNestCheckLen = dataNestCheck.length;
   for (let i = 0; i < dataNestCheckLen; i++) {
    dataNestCheck[i].dataset.nestCheck = "0";
   }
   for (let i = 0; i < theDropDownsLen; i++) {
    theDropDowns[i].dataset.status = 0;
    theDropDowns[i].nextElementSibling.style.display = "none";     
   }
   if (theCurStatus == 0) {
    cur.dataset.status = 1;
    cur.nextElementSibling.style.display = "";
   } else {
    cur.dataset.status = 0;
    cur.nextElementSibling.style.display = "none";
   }   
  } else { // is a nested dropdown
   let theParent = cur.parentElement;
   let theGrandparent = theParent.parentElement;
   dataNestCheck = theGrandparent.querySelectorAll("[data-nest-check]");
   /*if (theParent.nextElementSibling == null) {
    toggleDataCheck("b");
   } else {
    toggleDataCheck("a");
   }*/
   toggleDataCheck(optIndex.toString());
   // Show the nested dropdown clicked.
   if (cur.dataset.showhide == "1") {
    cur.dataset.nestCheck = "1";
   } else {
    cur.dataset.nestCheck = "0";
   }
  }
 }

 // Output links in dropdowns from pages built with test.
 function makeLinks(file) {
  let curDropdown = document.getElementById(file);  
  let nestedDropdown = curDropdown.getElementsByClassName("nestedDropdown");
  let nestedDropdownLen = nestedDropdown.length;     
  let nestDropArr = []; let nestDropOptions = [];  
  var iMakeLinks = function() {
   let xmlhttpsort = new XMLHttpRequest();
   xmlhttpsort.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     let curTxt = this.responseText;
     let curItem = curTxt.split("\n");      
     let i = 0;
     while (i < nestedDropdownLen) {
      let curInnerHTML = nestedDropdown[i].previousElementSibling.innerHTML;
      nestDropOptions.push(curInnerHTML);
      let nestDropArrs = [];
      for (ii = 0; ii < curItem.length; ii++) {
       if (curItem[ii].lastIndexOf(curInnerHTML+".html") > -1) {
        nestDropArrs.push(curItem[ii]);
       }
      }
      nestDropArr.push(nestDropArrs);
      i++
     }
     i = 0;    
     while (i < nestDropOptions.length) {
      let curNestedDropdown = nestedDropdown[i];
      curNestedDropdown.innerHTML = "<ul>";
      for (ii = 0; ii < nestDropArr[i].length; ii++) {
       if (location.href.indexOf("https://jhauga.github.io/htmlpreview.github.com/?") > -1) {
        curNestedDropdown.innerHTML += "<li><a target='_blank' href='" +
         "https://jhauga.github.io/htmlpreview.github.com/?" + cur_test_results +
         nestDropArr[i][ii].replace("COMMAND_USED", "source") + "'>" +          
         nestDropArr[i][ii].substring(nestDropArr[i][ii].lastIndexOf("/")+1, nestDropArr[i][ii].indexOf("-COMMAND_USED")) +
         "</a></li><br>";
        } else {
        curNestedDropdown.innerHTML += "<li><a target='_blank' href='" +
         nestDropArr[i][ii].replace("COMMAND_USED", "source") + "'>" +          
         nestDropArr[i][ii].substring(nestDropArr[i][ii].lastIndexOf("/")+1, nestDropArr[i][ii].indexOf("-COMMAND_USED")) +
         "</a></li><br>";
       }
      }
      curNestedDropdown.innerHTML += "</ul>";
      i++;
     }   
    }
   };
   xmlhttpsort.open("GET", "support/menu-"+file+"-links.txt", true);
   xmlhttpsort.send();
  };
  iMakeLinks();
 }

 // Set html links in dropdown by test by created.
 setTimeout(function() {makeLinks("unq");}, 400);
 setTimeout(function() {makeLinks("err");}, 450);
 setTimeout(function() {makeLinks("gen");}, 500);
 setTimeout(setSource(), 600);

 // Hide dropdowns when click anywhere.
 dataConversionTestPageContent.addEventListener("click", function() {  
  for (let i = 0; i < theDropDowns.length; i++) {
   let dropStatus = theDropDowns[i].dataset.status;
   if (dropStatus == 1) {
    theDropDowns[i].click();
   }
  }
 });


/*********************************************************************
                          DIFFERENT FILES
/*********************************************************************/
 var diffDefault=1;
//-- Output files with diff at end --
 var diffFiles = document.getElementById("diffFiles");
 var diffSeparator = "<br><hr><br>";
 var files, filesLen;
 var xmlhttp = new XMLHttpRequest();
 xmlhttp.onreadystatechange = function() {
  if (this.readyState == 4 && this.status == 200) {
  let errList = this.responseText;
  if (diffDefault == 1) {
   let testreg = /tests/g;
   let htmlreg = /html/g;
   let commandreg = /COMMAND_USED/g;
   let htmlltreg = /</g;
   let htmlgtreg = />/g;
   let openh3reg = /---h3-data-conversion-test_tag---/g; 
   let closeh3reg = /---c-h3-data-conversion-test_tag---/g;
   let linebrreg = /---br_hr_br-data-conversion-test_tag---/g;
   let errListTxt = errList.replace(testreg, "diff");
   errListTxt = errListTxt.replace(htmlreg, "txt");
   errListTxt = errListTxt.replace(commandreg, "");
   errListTxt = errListTxt.replace(htmlltreg, "&lt;");
   errListTxt = errListTxt.replace(htmlgtreg, "&gt;");
   errListTxt = errListTxt.replace(openh3reg, "<h3>");
   errListTxt = errListTxt.replace(closeh3reg, "</h3>");
   errListTxt = errListTxt.replace(linebrreg, "<br><hr><br>");
   files = errListTxt.split("\n");	 
   filesLen = files.length;
   for (i in files) {
    diffFiles.innerHTML += files[i] + "<br>";; 
   }    
  } else {
   let errListFiles = errList.split("\n");
   for (i = 0; i < errListFiles.length; i++) {
    let curErrFile = errListFiles[i];
    let errTitle = curErrFile.substr(curErrFile.lastIndexOf("/")+1);
    let curErrTitle = "<h3>" + errTitle + "</h3><small>Use bottom right to resize.</small>";
    let errFrame = document.createElement("iframe");
    if (curErrFile != "") {
     errFrame.src = curErrFile;
     errFrame.style.width = "95%";
     errFrame.style.minHeight = "350px";
     errFrame.style.resize = "vertical";    
     diffFiles.innerHTML += curErrTitle;
     diffFiles.appendChild(errFrame);
     diffFiles.innerHTML += diffSeparator;
     }
    }  
   }
  }
 };
 if (diffDefault == 1) {
  xmlhttp.open("GET", "diff/errs.txt", true);
 } else {
  xmlhttp.open("GET", "diff/errList.txt", true);
 }
 xmlhttp.send();

 // Output the stats for differnet files.
 var diffStats = document.getElementById("diffStats");
 xmlhttp = new XMLHttpRequest();
 xmlhttp.onreadystatechange = function() {
  if (this.readyState == 4 && this.status == 200) {
   // let diffStatText = this.responseText;
   diffStats.innerHTML = this.responseText;
  }
 };
 xmlhttp.open("GET", "support/diff-stats.txt", true);
 xmlhttp.send();

var runTimes = document.getElementById("runTimes");
xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
 if (this.readyState == 4 && this.status == 200) {
  //let runTimeText = this.responseText;
  runTimes.innerHTML = this.responseText;
 }
};
xmlhttp.open("GET", "support/run-times.txt", true);
xmlhttp.send();

// Lastely alert repo switch.
var alertText = "The top left menu buttons toggle the html\n" +
                "pages that were created with the repository\n" +
                "that is higlighted in the menu. Pages will open in\n" +
                "a new tab in browser.";
setTimeout(function() {alert(alertText);}, 1000);
