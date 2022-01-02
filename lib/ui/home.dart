import 'package:flix_app/ui/MOVIE.dart';
import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Games of Thrones",
    "Vikings"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flix-Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              movieCard(movieList[index], context),
              Positioned(
                  top: 10, child: movieImage(movieList[index].images[0])),
            ]);
            /* return Card(
          elevation: 4.5,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movieList[index].images[0]),
                    fit: BoxFit.cover
                  ),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(14.9)
                ),
                child: null,
              ),
            ),
            trailing: Text("..."),
            title: Text(movieList[index].title),
            subtitle: Text("${movieList[index].title}"),
           //onTap: () => debugPrint("Movie name: ${movies.elementAt(index)}"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MovieListViewDetails(movieName: movieList.elementAt(index).title,
                  movie: movieList[index],) ));
            },
          ),
        );*/
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 54,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(movie.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            )),
                      ),
                      Text(
                        "Rating: ${movie.imdbRating} / 10 ",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Released: ${movie.released}",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                      Text(
                        movie.runtime,
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                      Text(
                        movie.rated,
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListViewDetails(
                      movieName: movie.title,
                      movie: movie,
                    )))
      },
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imageUrl), fit: BoxFit.cover)),
    );
  }
}

//new routes
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails(
      {Key? key, required this.movieName, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" $movieName"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[2]),
          MovieDetailsHeaderWithPoster(movie: movie),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieExtraPosters(poster: movie.images),
        ],
      ),
      // body: Center(
      //   child: Container(
      //     child: RaisedButton(
      //       child: Text("Go back ${movie.director}"),
      //       onPressed: (){
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key? key, required this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumbnail), fit: BoxFit.cover)),
          ),
          Icon(
            Icons.play_circle_fill_outlined,
            color: Colors.white,
            size: 28,
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x00f5f5f5),
              Color(0xfff5f5f5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: 80,
      ),
    ]);
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;
  const MovieDetailsHeaderWithPoster({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: MovieDetailsHeader(movie: movie),
          )
        ],
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;
  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        Text(
          movie.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
        ),
        Text.rich(TextSpan(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(
                text: movie.plot,
              ),
              TextSpan(
                  text: "More...",
                  style: TextStyle(
                    color: Colors.indigo,
                  ))
            ]))
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;
  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRect(
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(
                  image: NetworkImage(poster), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field: "Cast: ", value: movie.actor),
          MovieField(field: "Directors: ", value: movie.director),
          MovieField(field: "Awards: ", value: movie.awards)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;
  const MovieField({Key? key, required this.field, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field",
          style: TextStyle(
              color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieExtraPosters extends StatelessWidget {
  final List<String> poster;
  const MovieExtraPosters({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "More Movie Posters".toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black26,
            ),
          ),
        ),
        Container(
          height: 180,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
              width: 8,
            ),
            itemCount: poster.length,
            itemBuilder: (context, index) => ClipRect(
              child: Container(
                width: MediaQuery.of(context).size.width/4,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(image: NetworkImage(poster[index]),
                  fit: BoxFit.cover)
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
