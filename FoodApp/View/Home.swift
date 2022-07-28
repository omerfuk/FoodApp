//
//  Home.swift
//  FoodApp
//
//  Created by Ömer Faruk Kılıçaslan on 28.07.2022.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 10 ){
                
                HStack(spacing: 15){
                    
                    Button {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.pink)
                    }

                    
                    Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver to")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                    
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing: 15) {
                    
                    TextField("Search", text: $HomeModel.search)
                    
                    if HomeModel.search != "" {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        .animation(.easeIn)

                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                Spacer()
            }
            
            //Side menu
            
            HStack {
                Menu(homeData: HomeModel)
                //Move effect from left
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
                
            }
            .background(
                Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                //Closing when taps on outside...
                    .onTapGesture(perform: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    })
            )
            
            //Non closable alert if permission denied
            
            if HomeModel.noLocation {
                Text("Please enable location access in settings to further move on...")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear {
            //calling location delegate
            
            HomeModel.locationManager.delegate = HomeModel
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
