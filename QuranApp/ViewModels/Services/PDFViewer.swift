//
//  PDFViewer.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI
import PDFKit

let document2 = PDFDocument(url: Bundle.main.url(forResource: "data", withExtension: "pdf")!)!

#if os(macOS)
public typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
public typealias ViewRepresentable = UIViewRepresentable
#endif

struct PDFViewer: ViewRepresentable {
    typealias UIViewType = PDFView
    let uiView = PDFKit.PDFView()
    @Binding var pageNumber: Int
    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        uiView.document = document2
        uiView.displayMode = .singlePage
        uiView.displayDirection = .horizontal
        uiView.usePageViewController(true)
        uiView.maxScaleFactor = uiView.scaleFactorForSizeToFit
        uiView.minScaleFactor = uiView.scaleFactorForSizeToFit
        uiView.autoScales = true
        uiView.displaysRTL = true
        uiView.delegate = context.coordinator
        
        uiView.displayDirection = .horizontal
        let pdfScrollView = uiView.subviews.first?.subviews.first as? UIScrollView
        pdfScrollView?.showsHorizontalScrollIndicator = false
        if let page = uiView.document?.page(at: pageNumber - 1) {
            uiView.go(to: page)
        }
        return uiView;
    }
    
    func updateUIView(_ uiView: PDFKit.PDFView, context: Context) {
        uiView.document = document2
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, PDFViewDelegate {
        var parent: PDFViewer
        var prevPage = -1
        
        init(_ parent: PDFViewer) {
            self.parent = parent
            super.init()
            NotificationCenter.default.addObserver(self, selector: #selector(pageChangeHandler(_:)), name: .PDFViewPageChanged, object: nil)
        }
        
        @objc func pageChangeHandler(_ notification: Notification) {
            if let thePage = parent.uiView.currentPage,
               let ndx = parent.uiView.document?.index(for: thePage),
               prevPage != ndx {
                parent.pageNumber = ndx + 1
                prevPage = ndx
            }
        }
    }
}
