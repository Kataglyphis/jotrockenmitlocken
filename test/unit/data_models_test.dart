import 'package:flutter_test/flutter_test.dart';

import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/book.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/FilmsPage/film.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/GamesPage/game.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/QuotesPage/quote.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BlockOverviewPage/block_entry.dart';
import 'package:anthology/Media/Files/file.dart';
import 'package:anthology/Media/DataTable/table_data.dart';
import 'package:anthology/Media/DataTable/datacell_content_strategies.dart';

class _MockTableData extends TableData {
  final List<String> cells;

  _MockTableData(this.cells);

  @override
  List<String> getCells() => cells;
}

void main() {
  group('Book', () {
    test('constructor stores title, author, isbn, comment', () {
      final book = Book(
        title: 'Necronomicon',
        author: 'H.P. Lovecraft',
        isbn: '978-3-123456-78-9',
        comment: 'Spooky',
      );

      expect(book.title, 'Necronomicon');
      expect(book.author, 'H.P. Lovecraft');
      expect(book.isbn, '978-3-123456-78-9');
      expect(book.comment, 'Spooky');
    });

    test('getCells() returns [title, author, isbn, comment]', () {
      final book = Book(
        title: 'Necronomicon',
        author: 'H.P. Lovecraft',
        isbn: '978-3-123456-78-9',
        comment: 'Spooky',
      );

      expect(book.getCells(), [
        'Necronomicon',
        'H.P. Lovecraft',
        '978-3-123456-78-9',
        'Spooky',
      ]);
    });
  });

  group('Film', () {
    test('constructor stores title, genre, actor, sonstiges', () {
      final film = Film(
        title: 'The Matrix',
        genre: 'Sci-Fi',
        actor: 'Keanu Reeves',
        sonstiges: 'Red pill or blue pill',
      );

      expect(film.title, 'The Matrix');
      expect(film.genre, 'Sci-Fi');
      expect(film.actor, 'Keanu Reeves');
      expect(film.sonstiges, 'Red pill or blue pill');
    });

    test('getCells() returns [title, genre, actor, sonstiges]', () {
      final film = Film(
        title: 'The Matrix',
        genre: 'Sci-Fi',
        actor: 'Keanu Reeves',
        sonstiges: 'Red pill or blue pill',
      );

      expect(film.getCells(), [
        'The Matrix',
        'Sci-Fi',
        'Keanu Reeves',
        'Red pill or blue pill',
      ]);
    });
  });

  group('Game', () {
    test('constructor stores title, developer, comment', () {
      final game = Game(
        title: 'The Witcher 3',
        developer: 'CD Projekt Red',
        comment: 'Great open world RPG',
      );

      expect(game.title, 'The Witcher 3');
      expect(game.developer, 'CD Projekt Red');
      expect(game.comment, 'Great open world RPG');
    });

    test('getCells() returns [title, developer, comment]', () {
      final game = Game(
        title: 'The Witcher 3',
        developer: 'CD Projekt Red',
        comment: 'Great open world RPG',
      );

      expect(game.getCells(), [
        'The Witcher 3',
        'CD Projekt Red',
        'Great open world RPG',
      ]);
    });
  });

  group('Quote', () {
    test('constructor stores author, content', () {
      final quote = Quote(
        author: 'Albert Einstein',
        content: 'Imagination is more important than knowledge.',
      );

      expect(quote.author, 'Albert Einstein');
      expect(quote.content, 'Imagination is more important than knowledge.');
    });

    test('getCells() returns [author, content]', () {
      final quote = Quote(
        author: 'Albert Einstein',
        content: 'Imagination is more important than knowledge.',
      );

      expect(quote.getCells(), [
        'Albert Einstein',
        'Imagination is more important than knowledge.',
      ]);
    });
  });

  group('BlockEntry', () {
    test('constructor stores title, date, comment', () {
      final block = BlockEntry(
        title: 'Vulkan progress',
        date: '12.03.2025',
        comment: 'Ray tracing implemented',
      );

      expect(block.title, 'Vulkan progress');
      expect(block.date, '12.03.2025');
      expect(block.comment, 'Ray tracing implemented');
    });

    test('getCells() returns [title, date, comment]', () {
      final block = BlockEntry(
        title: 'Vulkan progress',
        date: '12.03.2025',
        comment: 'Ray tracing implemented',
      );

      expect(block.getCells(), [
        'Vulkan progress',
        '12.03.2025',
        'Ray tracing implemented',
      ]);
    });
  });

  group('File', () {
    test('constructor stores title, additionalInfo, baseDir', () {
      final file = File(
        title: 'CV_Jonas_Heinle_english.pdf',
        additionalInfo: '~3.7MB English',
        baseDir: 'assets/documents/cv/',
      );

      expect(file.title, 'CV_Jonas_Heinle_english.pdf');
      expect(file.additionalInfo, '~3.7MB English');
      expect(file.baseDir, 'assets/documents/cv/');
    });

    test('fields are mutable', () {
      final file = File(
        title: 'original.pdf',
        additionalInfo: '1MB',
        baseDir: 'foo/',
      );

      file.title = 'updated.pdf';
      file.additionalInfo = '2MB';
      file.baseDir = 'bar/';

      expect(file.title, 'updated.pdf');
      expect(file.additionalInfo, '2MB');
      expect(file.baseDir, 'bar/');
    });
  });

  group('DataCellContentStrategies', () {
    test('has exactly 2 values: text and textButton', () {
      const values = DataCellContentStrategies.values;

      expect(values.length, 2);
      expect(values, contains(DataCellContentStrategies.text));
      expect(values, contains(DataCellContentStrategies.textButton));
    });

    test('text index is 0', () {
      expect(DataCellContentStrategies.text.index, 0);
    });

    test('textButton index is 1', () {
      expect(DataCellContentStrategies.textButton.index, 1);
    });
  });

  group('TableData (abstract interface)', () {
    test('subclass must implement getCells()', () {
      final mock = _MockTableData(['a', 'b', 'c']);

      expect(mock.getCells(), ['a', 'b', 'c']);
    });

    test('all concrete subclasses implement getCells()', () {
      final book = Book(title: 't', author: 'a', isbn: 'i', comment: 'c');
      final film = Film(title: 't', genre: 'g', actor: 'a', sonstiges: 's');
      final game = Game(title: 't', developer: 'd', comment: 'c');
      final quote = Quote(author: 'a', content: 'c');
      final block = BlockEntry(title: 't', date: 'd', comment: 'c');

      expect(book.getCells(), isNotEmpty);
      expect(film.getCells(), isNotEmpty);
      expect(game.getCells(), isNotEmpty);
      expect(quote.getCells(), isNotEmpty);
      expect(block.getCells(), isNotEmpty);
    });
  });
}
