abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsNavBarState extends NewsStates {}

class NewsGetBusinessSuccesState extends NewsStates {}

class NewsGetBusinessErroreState extends NewsStates {
  final String error;

  NewsGetBusinessErroreState(this.error);
}

class NewsLoadingBusinessState extends NewsStates {}

class NewsGetSportSuccesState extends NewsStates {}

class NewsGetSportErroreState extends NewsStates {
  final String error;

  NewsGetSportErroreState(this.error);
}

class NewsLoadingSportState extends NewsStates {}

class NewsGetScienceSuccesState extends NewsStates {}

class NewsGetScienceErroreState extends NewsStates {
  final String error;

  NewsGetScienceErroreState(this.error);
}

class NewsLoadingScienceState extends NewsStates {}

class NewsGetSearchErroreState extends NewsStates {
  final String error;

  NewsGetSearchErroreState(this.error);
}

class NewsLoadingSearchState extends NewsStates {}

class NewsGetSearchSuccesState extends NewsStates {}

class NewsChangeAppTheme extends NewsStates {}
