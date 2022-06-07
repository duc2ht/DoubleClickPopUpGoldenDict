set savedClipboard to the clipboard

-- Copy selected text to clipboard:
tell application "System Events" to keystroke "c" using {command down}
delay 0.5 -- Without this, the clipboard may have stale data.

set theSelectedText to the clipboard

tell application "Finder"
	POSIX path of (application file id "org.goldendict" as alias)
end tell

set appPath to result

if application id "org.goldendict" is running then
	tell application id "org.goldendict"
		do shell script (appPath & "/Contents/MacOS/GoldenDict " & theSelectedText)
		set the clipboard to savedClipboard
	end tell
else
	tell application id "org.goldendict"
		activate
	end tell
	do shell script (appPath & "/Contents/MacOS/GoldenDict " & theSelectedText)
	set the clipboard to savedClipboard
end if
