import UIKit

class ThemeChooserListViewController: UICollectionViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Sections, Theme>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Theme>

    private enum Sections: CaseIterable {
        case first
    }

    private var dataSource: DataSource!

    private var modelThemes: [Theme] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove Faces for testing
        modelThemes = Theme.sampleThemes
        modelThemes.remove(at: 2)

        collectionView.collectionViewLayout = listLayout()
        
        dataSource = makeDataSource()

        updateUI()

        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    private func updateUI(animatingDifferences: Bool = true) {
        // perform query
        modelThemes.sort { $0.title < $1.title }

        var snapshot = Snapshot()
        snapshot.appendSections(Sections.allCases)
        snapshot.appendItems(modelThemes, toSection: .first)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func makeDataSource() -> DataSource {
        let themeCellRegistration = ThemeCellRegistration()

        let datasource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, theme: Theme) in
            let themeCell = collectionView.dequeueConfiguredReusableCell(using: themeCellRegistration, for: indexPath, item: theme)
            return themeCell
        }
        
        return datasource
    }

    private func ThemeCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Theme> {
        return UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, theme: Theme) in
            var content = cell.defaultContentConfiguration()

            // increase 'text' default font size
            let fontSize = 44.0
            content.textProperties.font = content.textProperties.font.withSize(fontSize)
            content.text = theme.title

            let emoji = pickRandomEmoji(from: theme.emojis)
            content.image = emoji.textToImage(withSize: fontSize)

            cell.contentConfiguration = content
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let theme = dataSource.itemIdentifier(for: indexPath) else {
//            collectionView.deselectItem(at: indexPath, animated: true)
//            return
//        }

        collectionView.deselectItem(at: indexPath, animated: true)

        modelThemes.remove(at: indexPath.item)

        let facesTheme = Theme(title: "Faces", emojis: "😃🤣😍🤢🤪🤓😬🙄😡😎🥶🤥😇🤠🤮🙁😤😫🥳😁😮🤐😳😅🥺", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), faceDownColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), faceUpColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        modelThemes.append(facesTheme)

        updateUI()
        
//        let alert = UIAlertController(title: theme.title, message: "", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) {_ in collectionView.deselectItem(at: indexPath, animated: true)}
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
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
