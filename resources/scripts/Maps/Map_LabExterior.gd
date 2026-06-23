extends allMaps

func awaitJournalOpen():
	await GlobalSignalBus.journalOpened
