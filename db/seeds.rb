
users = [
	{ email: "hammond@jp-park.net", password: "playinggod", name: "John Hammond", role: "doctor", authentication_token: "qANOQg" },
	{ email: "grant@jp-park.net", password: "thisseemssafe", name: "Alan Grant", role: "scientist", authentication_token: "A4BpSG" },
	{ email: "sattler@jp-park.net", password: "thisseemssafe", name: "Ellie Sattler", role: "scientist", authentication_token: "FB3K59" },
	{ email: "malcolm@jp-park.net", password: "uh-my-uh-password", name: "Ian Malcolm", role: "goldblum", authentication_token: "88X6wX" },
	{ email: "nedry@jp-park.net", password: "magicword", name: "Dennis Nedry", role: "builder", authentication_token: "IALVOP" },
]
User.create(users)
