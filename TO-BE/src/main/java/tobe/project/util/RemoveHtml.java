package tobe.project.util;

import org.springframework.stereotype.Component;

@Component("removeHtml")
public class RemoveHtml {

	public String removeHtml(String html) throws Exception{
		return html.replaceFirst("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}
}
