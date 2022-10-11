class GraphqlQueries {
  static getMediaList() {
    return """query (\$id: Int, \$page: Int, \$perPage: Int, \$search: String) {
      Page (page: \$page, perPage: \$perPage) {
        pageInfo {
          total
          currentPage
          lastPage
          hasNextPage
          perPage
        }
        media (id: \$id, search: \$search) {
          id
          type
          coverImage {
            large
          }
          title {
            romaji
          }
        }
      }
    }""";
  }

  static getMediaDetail() {
    return """query (\$id: Int) {
        Media(id: \$id, type: ANIME) {
          id
          title {
            romaji
            native
            english
            userPreferred
          }
          type
          startDate {
            year
            month
            day
          }
          endDate {
            year
            month
            day
          }
          season
          seasonYear
          format
          status
          episodes
          duration
          isAdult
          genres
          description
          bannerImage
          coverImage {
            large
          }
      }
    }""";
  }
}
