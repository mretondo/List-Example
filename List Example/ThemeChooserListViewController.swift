import UIKit

class ThemeChooserListViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Sections, Theme>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Theme>

    private enum Sections: CaseIterable {
        case first
    }

    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = listLayout()
        
        dataSource = makeDataSource()
        applySnapshot(to: dataSource, animatingDifferences: false)

        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    private func applySnapshot(to dataSource: DataSource, animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Sections.allCases)
        snapshot.appendItems(Theme.sampleThemes)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func ThemeCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Theme> {
        return UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: Theme) in
//            let theme = Theme.sampleThemes[indexPath.item]

            var content = cell.defaultContentConfiguration()

            // increase 'text' default font size
            let fontSize = 44.0
            content.textProperties.font = content.textProperties.font.withSize(fontSize)
//            content.text = theme.title
            content.text = itemIdentifier.title

//            let emoji = pickRandomEmoji(from: theme.emojis)
            let emoji = pickRandomEmoji(from: itemIdentifier.emojis)
            content.image = emoji.textToImage(withSize: fontSize)

            cell.contentConfiguration = content
        }
    }

    private func makeDataSource() -> DataSource {
        let registration = ThemeCellRegistration()
        return DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Theme) in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
        }
    }
}

public func pickRandomEmoji(from emojiChoices: String) -> String {
    var emoji = "?"

    if emojiChoices.count > 0 {
        let offset = emojiChoices.count.random
        let index = emojiChoices.index(emojiChoices.startIndex, offsetBy: offset)
        emoji = String(emojiChoices[index...index])
    }

    return emoji
}

extension Int {
    var random: Int {
        if self > 0 {
            return Int.random(in: 0 ..< self)
        }
        else if self < 0 {
            // get random number in positive range then negate it
            return -Int.random(in: 0 ..< abs(self))
        }
        else {
            // no emoji to randomise
            return 0
        }
    }
}

#if os(iOS)
public extension String {
    //
    // convert the string to an UIImage
    //
    func textToImage(withSize fontSize: CGFloat) -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: fontSize) // you can change your font size here
        let stringAttributes = [NSAttributedString.Key.font: font]

        // calculate size of image
        var imageSize = nsString.size(withAttributes: stringAttributes)
        // raise fractional size values to the nearest higher integer
        imageSize.height = ceil(imageSize.height)
        imageSize.width = ceil(imageSize.width)

        // start ImageContext
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)

        // sets the color of subsequent stroke and fill operations
        UIColor.clear.set()

        let rect = CGRect(origin: .zero, size: imageSize)
        UIRectFill(rect)

        // draw text within current graphics context
        nsString.draw(at: .zero, withAttributes: stringAttributes)

        // create image from context
        let image = UIGraphicsGetImageFromCurrentImageContext()

        // end ImageContext
        UIGraphicsEndImageContext()

        return image ?? UIImage()
    }
}
#endif
