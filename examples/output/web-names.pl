web_uri(web(be.ugent, jos), "https://data.ugent.be/id/jos").
web_uri(web(com.example, jos), "https://example.com/id/jos").
web_uri(web(be.ugent, idlab), "https://data.ugent.be/id/idlab").
web_uri(web(be.ugent, ugent), "https://data.ugent.be/id/ugent").
web_uri(web(eyereasoner.github, eyelang), "https://github.com/eyereasoner/eyelang").
web_uri(web(org.schema, maintainer), "https://schema.org/maintainer").
affiliated_with(web(be.ugent, jos), web(be.ugent, idlab)).
affiliated_with(web(be.ugent, jos), web(be.ugent, ugent)).
project_contact(web(eyereasoner.github, eyelang), web(be.ugent, jos), "josderoo@gmail.com").
same_local_name(web(be.ugent, jos), web(com.example, jos), jos).
